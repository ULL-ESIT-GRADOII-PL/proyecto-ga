(() => {
    "use strict";
    const CompoundType = (type, children) => {
        AbstractType.call(type,children);
    };
    CompoundType.prototype = Object.create(AbstractType.prototype);
    CompoundType.prototype.constructor = CompoundType;
    module.exports = CompoundType;
})();