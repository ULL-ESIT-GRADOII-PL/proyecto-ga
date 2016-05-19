/*
 * PEGjs for a "Pl-0" like language
 * Pl-0 IMPLEMENTATION BY WIKIPEDIA
*/

{
  var tree = function(f, r) {
    if (r.length > 0) {
      var last = r.pop();
      var result = {
        type:  last[0],
        left: tree(f, r),
        right: last[1]
      };
    }
    else {
      var result = f;
    }
    return result;
  }
}

program = b:block { /* Declaración de la estructura principal que contendrá a todas las demás */

  b.name = { /* Atributo name que contiene el tipo */
    type: 'ID', 
    value: "$main"
  }; 
  b.params = []; /* Array que contiene los parámetros del programa */
                  
  return b;
}

block = cD:constantDeclaration? vD:variableDeclaration? fD:functionDeclaration* st:statement* { 

  let constants = cD? cD : []; /* constanst puede estar vacía si no se realiza declaración de las mismas */
  let variables = vD? vD : []; /* variables puede estar vacía si no se realiza declaración de las mismas */ 
              
  return { /* Definición del valor semántico */
      type: 'BLOCK', 
      constants: constants, 
      variables: variables,
      functions: fD,
      main: st
  };
}

constantDeclaration = CONST id:ID ASSIGN nu:NUMBER rest:(COMMA ID ASSIGN NUMBER)* SEMICOLON { /* const ejemplo1 = 1, ejemplo2 = 2; */
  
  let declaration = rest.map( ([_, id, __, nu]) => [id.value, nu.value] ); /* Ignoramos la coma y el igual, ya que no nos interesa */
  
  return [[id.value, nu.value]].concat(declaration) /* El valor semántico será un array de parejas con los id y los valores de las constantes */
}

variableDeclaration = VAR id:ID ASSIGN? val1:factor? rest:(COMMA ID ASSIGN? factor?)* SEMICOLON {  /* Permitimos la inicialización de las variables */ 
  
  let v1 = val1? val1 : undefined; /* val1 puede estar vacía si no se realiza declaración de las mismas */
  let declaration = rest.map( ([_, id, __, val2]) => [id.value, val2] ); /* Ignoramos la coma y el igual */
  
  declaration.forEach( (array) => { array[1] = undefined } ); /* eliminamos el null como valor de inicialiazión de la variable */
                      
  return [[id.value, v1]].concat(declaration) /* El valor semántico será un array de parejas con los nombres de las variables declaradas */
}

functionDeclaration = FUNCTION id:ID LEFTPAR !COMMA param1:ID? rest:(COMMA ID)* RIGHTPAR CL b:block CR SEMICOLON { /* Evitamos ejemplo(, parametro) */
  
  let params = param1? [param1] : []; /* Puede estar vacío si no declaran parametros, o contener el primer parámetro */
  if(param1) /* Si existe el primer parámetro */
    params = params.concat(rest.map(([_, p]) => p)); /* Concatenamos con el primer parámetro anterior el resto, si los hubiese (ignoramos comas) */
    
  let ret = undefined; /* Contemplamos la posibilidad de que no exista el return */
  let i = b.main.length - 1; /* Almacenamos la posición del último elemento, que se debería corresponder con el return si existe */
  if(b.main[i].type = 'RETURN'); /* Si existe el return */
    ret = b.main[i].children;

  return Object.assign({ /* Asignamos al objeto del bloque que la contiene, el nuevo tipo, es decir, FUNCTION */
      type: 'FUNCTION',
      name: id,
      params: params, /* Array con los nombres de los parámetros */
      ret: ret
  }, b);
}

statement = CL s1:statement? rest:(SEMICOLON statement)* SEMICOLON* CR { /* Sentencias, aceptando compuestas entre {} */
              
              let array_st = [];
              if (s1) /* Si existe la primera sentencia */
                  array_st.push(s1); /* Lo introducimos en el array de sentencias */
              return {
                  type: 'COMPOUND', 
                  children: array_st.concat(rest.map( ([_, statement]) => statement )) /* Introducimos el resto de sentencias en el array */
               };
            }
       
  / IF e:assign THEN st:statement ELSE sf:statement { /* Sentencias IF-THEN-ELSE */
      return {
          type: 'IFELSE',
          cond:  e,
          children_if: st,
          children_else: sf,
      };
    }
  / IF e:assign THEN st:statement { /* Sentencias IF-THEN */
      return {
          type: 'IF',
          cond:  e,
          children: st
      };
    }
  / WHILE e:assign DO st:statement { /* Bucle WHILE */
      return {
          type: 'WHILE',
          cond: e,
          children: st
      };
    }
  / FOR LEFTPAR vc:assign SEMICOLON cond:condition SEMICOLON id3:ID op1:ADD ADD RIGHTPAR st:statement { /* Bucle FOR */

      return {
          type: 'FOR',
          variable: vc.left,
          condition: cond.type,
          increment: op1,
          children: st
      };
    }
  / RETURN a:value? { /* Se permite únicamente el return */
      
      return { 
          type: 'RETURN', 
          children: a? a : undefined 
        };
    }
  / assign

assign = i:ID ASSIGN e:condition { /* Asignaciones, ejemplo = 5; Punto y coma opcional */
            
    return {
        type: '=', 
        left: i, 
        right: e
    }; 
}
/ condition
					 
condition	= l:exp op:COND r:exp { /* Condiciones */

    return { 
        type: op, /* Como tipo usamos el token COND usado en la comparación */
				left: l,
				right: r
		};
}
/	exp

exp    = t:term   r:(ADD term)*   { return tree(t,r); }
term   = f:factor r:(MUL factor)* { return tree(f,r); }

factor = NUMBER
       / name:ID LEFTPAR a:assign? rest:(COMMA assign)* RIGHTPAR { /* Llamadas a funciones */
         
          let array_arg = [];
          if (a)
            array_arg.push(a); /* Incluimos el primer argumento en el array */
           
          return { 
              type: 'CALL',
              func: name,
              arguments: array_arg.concat(rest.map(([_, exp]) => exp)) /* Concatenamos en el array con el resto de argumentos */
          };
         }
       / ID
       / LEFTPAR t:assign RIGHTPAR   { return t; }
       / LEFTSQBR n:NUMBER RIGHTSQBR { 
            return {
                type: 'ARRAY', 
                size: n.value
            };
         }

value = NUMBER /* Permitidos identificadores y números únicamente */
       / ID

/* -----------> DECLARACIÓN DE LOS TOKENS */

_ "( \t\n\r)"     = $[ \t\n\r]*
COND "condition"  =	_ op:("=="/"!="/"<="/">="/"<"/">") _ { return op; } /* PEGjs descarta el resto de operadores si se cumple uno, >= y > */
ASSIGN            = _ op:'=' _  { return op; }
ADD "operator"    = _ op:[+-] _ { return op; }
MUL "operator"    = _ op:[*/] _ { return op; }
LEFTPAR           = _"("_
RIGHTPAR          = _")"_
LEFTSQBR          = _"["_
RIGHTSQBR         = _"]"_
CL                = _"{"_
CR                = _"}"_
CONST             = _ "const" _
VAR               = _ "var" _
FUNCTION          = _ "function" _
IF                = _ "if" _
THEN              = _ "then" _
ELSE              = _ "else" _
WHILE             = _ "while" _
DO                = _ "do" _
FOR               = _ "for" _
RETURN            = _ "return" _
SEMICOLON         = _";"_
COMMA             = _","_
ID "identifier"   = _ id:$([a-zA-Z_][a-zA-Z_0-9]*) _ { return { type: 'ID', value: id }; }
NUMBER "number"   = _ digits:$[0-9]+ _ { return { type: 'NUM', value: parseInt(digits, 10) }; }
