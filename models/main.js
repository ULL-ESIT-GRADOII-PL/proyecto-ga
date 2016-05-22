(() =>{
	"use strict";
	var PEG = require("./parsernode.js");
	const parser = (input) =>{
		const tree = PEG.parse(input);
		console.log(tree);
	};
	module.exports = parser;
});
