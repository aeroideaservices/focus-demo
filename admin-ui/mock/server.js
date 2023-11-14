/* eslint-disable global-require */
const jsonServer = require('json-server');
const path = require('path');

const server = jsonServer.create();
const router = jsonServer.router(path.join(__dirname, 'db.json'));
const middlewares = jsonServer.defaults();
// Set default middlewares (logger, static, cors and no-cache)
server.use(middlewares);

// To handle POST, PUT and PATCH you need to use a body-parser
// You can use the one used by JSON Server
server.use(jsonServer.bodyParser);
server.use((req, res, next) => {
  if (req.method === 'POST') {
    req.body.createdAt = Date.now();
  }
  // Continue to JSON Server router
  next();
});

// API
server.get('/models', async (req, res) => {
  const SUCCESS_LIM_10 = require('./data/MODELS/GET_MODELS_LIM_10.json');
  const SUCCESS_LIM_16 = require('./data/MODELS/GET_MODELS_LIM_16.json');
  const SUCCESS_LIM_32 = require('./data/MODELS/GET_MODELS_LIM_32.json');
  const SUCCESS_LIM_64 = require('./data/MODELS/GET_MODELS_LIM_64.json');
  const limit = req.query['limit'];

  switch (limit) {
    case '10':
      res.jsonp(SUCCESS_LIM_10);
      break;
    case '16':
      res.jsonp(SUCCESS_LIM_16);
      break;
    case '32':
      res.jsonp(SUCCESS_LIM_32);
      break;
    case '64':
      res.jsonp(SUCCESS_LIM_64);
      break;
    default:
      res.jsonp(SUCCESS_LIM_10);
      break;
  }
});

server.use(router);
const port = 2233;
server.listen(2233, () => {
  // eslint-disable-next-line no-console
  console.info(`JSON Server is running on port ${port}`);
});
