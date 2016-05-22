
(() => {
    "use strict";
    const Identifier = (type, value) => {
      AbstactType.call(type);
      this.value = value;
    };
    Identifier.prototype = Object.create(AbstactType.prototype);
    Identifier.prototype.constructor = Identifier;
    module.exports = Identifier;
})();