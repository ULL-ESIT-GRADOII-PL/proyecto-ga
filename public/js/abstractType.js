
//
(() => {
   "use strict";
   const AbstractType = (type, children) => {
     this.type = type;
     this.children = children || null;
   };
    module.exports = AbstractType;
})();