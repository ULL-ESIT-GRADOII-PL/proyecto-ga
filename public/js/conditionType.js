
(() => {
   "use strict";
   const Condition = (type, left, right) => {
     AbstractType.call(type);
     this.left = left;
     this.right = right;
   };
   Condition.prototype = Object.create(AbstractType.prototype);
   Condition.prototype.constructor = Condition;
})();