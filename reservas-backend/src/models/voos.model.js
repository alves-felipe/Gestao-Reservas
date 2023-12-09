// See https://sequelize.org/master/manual/model-basics.html
// for more of what you can do here.
const Sequelize = require('sequelize')
const DataTypes = Sequelize.DataTypes

module.exports = function (app) {
  const sequelizeClient = app.get('sequelizeClient')
  const voos = sequelizeClient.define('voos', {
    valor: {
      type: DataTypes.DECIMAL(50, 2),
      allowNull: false,
    },
    detalhes: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    horarioPartida: {
      type: DataTypes.DATE,
      allowNull: false,
    },
    horarioChegada: {
      type: DataTypes.DATE,
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
  voos.associate = function (models) {
    // Define associations here
    // See https://sequelize.org/master/manual/assocs.html
    const {
      aeroportos
    } = models

    voos.belongsTo(aeroportos, { foreignKey: 'origem' })
    voos.belongsTo(aeroportos, { foreignKey: 'destino' })
  }

  return voos
}
