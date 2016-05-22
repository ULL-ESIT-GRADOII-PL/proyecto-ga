
(() => {
    "use strict";
    const FunctionType = (type, id, args) => {
        AbstractType.call(type);
        this.id = id;
        this.args = args;
    };
    FunctionType.prototype = Object.create(AbstractType.prototype);
    FunctionType.prototype.constructor = FunctionType;
    module.exports = FunctionType;
})();