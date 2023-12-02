const app = require('../../src/app');

describe('\'passagens\' service', () => {
  it('registered the service', () => {
    const service = app.service('passagens');
    expect(service).toBeTruthy();
  });
});
