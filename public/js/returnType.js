
(() => {
   "use strict"; 
   const Return = (type, children) => {
       AbstractType.call(this, type, children);
   };
   Return.prototype = Object.create(AbstractType.prototype);
   Return.prototype.constructor = Return;
   module.exports = Return;
})();