
(() => {
    "use strict";
    const IfThenElseStatement = (type, condition, statement, restStatement) => {
      IfStatement.call(this,type,statement);
      this.type = type;
      this.restStatement = restStatement;
    };
    IfThenElseStatement.prototype = Object.create(IfStatement.prototype);
    IfThenElseStatement.prototype.constructor = IfThenElseStatement;
    module.exports = IfThenElseStatement;
})();