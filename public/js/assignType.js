

(() => {
    const Assign = (type, left, right) => {
        AbstractType.call(this, type);
        this.left = left;
        this.right = right;
    };
    Assign.prototype = Object.create(AbstractType.prototype);
    Assign.prototype.constructor = Assign;
    module.exports = Assign;
})();