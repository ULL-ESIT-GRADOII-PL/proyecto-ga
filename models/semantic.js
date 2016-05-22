
(() => {
    "use strict";
    //   La fase de análisis semántico recibe el árbol AST de la fase sintáctica
    const semantic = (tree) => {
        //  Construimos la tabla de símbolos
        eachBlockPre(tree, (node, args) => {
            node.symbolTable = {
              nombre : node.name.value,
              constantes : node.constants,
              variables : node.variables,
              funciones : node.functions,
              parametros : node.params
            };
        }, null);
        //  Definimos la relacion padre-hijo
        eachBlockPre(tree, (node, args) => {
            node.functions.forEach((funct) => {
              funct.symbolTable.padre = node.name.value,
              funct.symbolTable.tabla_padre = node.symbolTable
            });
        }, null);
    };

    //  Recorrido en preorden
    //  Recibe un nodo del árbol
    //  La acción a realizar
    //  El padre del nodo actual
    const eachBlockPre = (tree, action, args) => {
        action(tree,args);    //  Ejecutamos la acción sobre el nodo
        //  El árbol es un objeto que tiene un atributo funciones y para cada una de ellas construimos su tabla de símbolos
        tree.functions.forEach((func) => eachBlockPre(func, action, args));
    };
    
    module.exports = semantic;
})();
