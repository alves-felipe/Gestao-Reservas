// Initializes the `voos` service on path `/voos`
const { Voos } = require('./voos.class');
const createModel = require('../../models/voos.model')
const hooks = require('./voos.hooks');

module.exports = function (app) {
  const options = {
    Model: createModel(app),
    paginate: app.get('paginate')
  };

  // Initialize our service with any options it requires
  app.use('/voos', new Voos(options, app));

  // Get our initialized service so that we can register hooks
  const service = app.service('voos');

  service.hooks(hooks);
};
