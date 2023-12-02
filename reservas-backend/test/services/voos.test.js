const app = require('../../src/app');

describe('\'voos\' service', () => {
  it('registered the service', () => {
    const service = app.service('voos');
    expect(service).toBeTruthy();
  });
});
