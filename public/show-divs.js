//-----> MÉTODOS PARA LA VISIBILIDAD DE LOS DIV.

function show_ast() { // Método para mostrar el div del árbol semántico.

	document.getElementById("output").style.visibility = 'visible';
	document.getElementById("output2").style.visibility = 'hidden';
}

function show_semantic() { // Método para mostrar el div del formulario.

	document.getElementById("output2").style.visibility = 'visible';
	document.getElementById("output").style.visibility = 'hidden';
}