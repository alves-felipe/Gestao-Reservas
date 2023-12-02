const app = require('../../src/app');

describe('\'aeroportos\' service', () => {
  it('registered the service', () => {
    const service = app.service('aeroportos');
    expect(service).toBeTruthy();
  });
});
