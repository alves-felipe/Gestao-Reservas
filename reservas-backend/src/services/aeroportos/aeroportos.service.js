// Initializes the `aeroportos` service on path `/aeroportos`
const { Aeroportos } = require('./aeroportos.class');
const createModel = require('../../models/aeroportos.model')
const hooks = require('./aeroportos.hooks');

module.exports = function (app) {
  const options = {
    Model: createModel(app),
    paginate: app.get('paginate')
  };

  // Initialize our service with any options it requires
  app.use('/aeroportos', new Aeroportos(options, app));

  // Get our initialized service so that we can register hooks
  const service = app.service('aeroportos');

  service.hooks(hooks);
};
