const express = require('express');
const app = express();
const port = 3000;

const routes = require('./routes/index.route');

app.get('/', (req, res) => res.send('Hello World!'));

app.use(routes);

app.listen(port, () => console.log(`Example app listening on port ${port}!`));

module.exports = { app };