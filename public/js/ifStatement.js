
(() => {
   "use strict";
   const IfStatement = (type, condition, statement) => {
     AbstactType.call(this, type, statement);
     this.condition = condition;
   };
   IfStatement.prototype = Object.create(AbstractType.prototype);
   IfStatement.prototype.constructor = IfStatement;
   module.exports = IfStatement;
});