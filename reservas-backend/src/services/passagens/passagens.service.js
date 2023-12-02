// Initializes the `passagens` service on path `/passagens`
const { Passagens } = require('./passagens.class');
const createModel = require('../../models/passagens.model')
const hooks = require('./passagens.hooks');

module.exports = function (app) {
  const options = {
    Model: createModel(app),
    paginate: app.get('paginate')
  };

  // Initialize our service with any options it requires
  app.use('/passagens', new Passagens(options, app));

  // Get our initialized service so that we can register hooks
  const service = app.service('passagens');

  service.hooks(hooks);
};
