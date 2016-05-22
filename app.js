"use strict";
const express = require('express');
const app = express();
const path = require('path');
const expressLayouts = require('express-ejs-layouts');
var util = require('util');
app.set('port', (process.env.PORT || 8000));

app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');
app.use(expressLayouts);

app.use(express.static(__dirname + '/public'));

app.get('/', (request, response) => {
  response.render('index', {title : 'Proyecto Procesadores de Lenguajes'});
});

//  Cargamos los modulos para el analisis sintactico y semantico
const PEG = require('./models/parsernode.js');
const semantic =  require('./models/semantic');

//	Definimos la ruta para el parser
app.get('/parser', (req,resp) =>{
    //  Obtenemos el árbol de análisis sintáctico
    let tree = PEG.parse(req.query.input);
    console.log(util.inspect(tree, {depth: null}));
	resp.send({"tree" : tree});
});

app.listen(app.get('port'),() =>{
   console.log(`Node app is listening at: ${app.get('port')}`);
});
