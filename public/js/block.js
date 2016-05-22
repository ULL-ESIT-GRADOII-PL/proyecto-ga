
(() => {
    "use strict";
    const Block = (type, constants, variables, functions, statements) => {
      AbstactType.call(this, type, statements);  
      this.constants = constants;
      this.variables = variables;
      this.functions = functions;
    };
    Block.prototype = Object.create(AbstactType.prototype);
    Block.prototype.constructor = Block;
    
    module.exports = Block;
})();