// See https://sequelize.org/master/manual/model-basics.html
// for more of what you can do here.
const Sequelize = require('sequelize')
const DataTypes = Sequelize.DataTypes

module.exports = function (app) {
  const sequelizeClient = app.get('sequelizeClient')
  const aeroportos = sequelizeClient.define('aeroportos', {
    name: {
      type: DataTypes.STRING,
      allowNull: false,
      unique: true
    },
  }, {
    hooks: {
      beforeCount (options) {
        options.raw = true
      }
    }
  })

  // eslint-disable-next-line no-unused-vars
  aeroportos.associate = function (models) {
    // Define associations here
    // See https://sequelize.org/master/manual/assocs.html

    // const {
    //   voos
    // } = models

    
    // aeroportos.hasOne(voos)
    
  }

  return aeroportos
}
