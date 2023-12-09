// See https://sequelize.org/master/manual/model-basics.html
// for more of what you can do here.
const Sequelize = require('sequelize')
const DataTypes = Sequelize.DataTypes

module.exports = function (app) {
  const sequelizeClient = app.get('sequelizeClient')
  const passagens = sequelizeClient.define('passagens', {
    assento: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },

  }, {
    hooks: {
      beforeCount (options) {
        options.raw = true
      }
    }
  })

  // eslint-disable-next-line no-unused-vars
  passagens.associate = function (models) {
    // Define associations here
    // See https://sequelize.org/master/manual/assocs.html
    const {
      voos,
      users
    } = models

    
    passagens.belongsTo(voos, { foreignKey: 'voo_id' })
    passagens.belongsTo(users, { foreignKey: 'user_id' })
  }

  return passagens
}
