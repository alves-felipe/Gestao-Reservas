const users = require('./users/users.service.js')
const roles = require('./roles/roles.service.js');
const aeroportos = require('./aeroportos/aeroportos.service.js');
const passagens = require('./passagens/passagens.service.js');
const voos = require('./voos/voos.service.js');
// eslint-disable-next-line no-unused-vars
module.exports = function (app) {
  app.configure(users)
  app.configure(roles);
  app.configure(aeroportos);
  app.configure(passagens);
  app.configure(voos);
}
