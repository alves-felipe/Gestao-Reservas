const { Service } = require('feathers-sequelize')
const sequelize = require('sequelize')

exports.Passagens = class Passagens extends Service {
    constructor (options, app) {
        super(options);
        this.options = options || {};
        this.app = app || {};
      }
    async find(params) {
        const sequelize = this.app.get('sequelizeClient');
        const ok = await sequelize.query('CALL relatorio()');
        return ok;
    }
};
