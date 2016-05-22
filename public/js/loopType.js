

(() =>{
   "use strict";
   const LoopType = (type, condition,children) => {
       AbstractType.call(this, type, children);
       this.condition = condition;
   };
   LoopType.prototype = Object.create(AbstractType.prototype);
   LoopType.prototype.constructor = LoopType;
   
   module.exports = LoopType;
})();