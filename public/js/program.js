

(() => {
    "use strict";
    const Program = (block) => {
      AbstactType.call(this, "Program");
      this.block = block;
    };
    Program.prototype = Object.create(AbstactType.prototype);
    Program.prototype.constructor = Program;
    
    module.exports = Program;
})();