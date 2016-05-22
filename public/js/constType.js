
(() => {
    "use strict";
    
    const Const = (type, id, value) => {
        AbstactType.call(this, type, id);
        this.id = id;
        this.value = value;
    };
    Const.prototype = Object.create(AbstactType.prototype);
    Const.prototype.constructor = Const;
    module.exports = Const;
})();