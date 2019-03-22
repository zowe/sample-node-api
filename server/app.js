const express = require('express');
const http = require('http');
const https = require('https');
const fs = require('fs');
const path = require("path");
var cors = require('cors')

const { HTTP_PORT, HTTPS_PORT } = require('./config.json');
console.log(HTTPS_PORT);


const privateKey = fs.readFileSync(path.resolve(__dirname, "../sslcert/server.key"), 'utf8');
const certificate = fs.readFileSync(path.resolve(__dirname, "../sslcert/server.cert"), 'utf8');
const credentials = { key: privateKey, cert: certificate };

const app = express();

//TODO: use for whitelist only
app.use(cors());

const routes = require('./routes/index.route');

app.get('/', (req, res) => res.send('Hello World!'));

app.use(routes);


const httpServer = http.createServer(app);
const httpsServer = https.createServer(credentials, app);

httpServer.listen(HTTP_PORT);
httpsServer.listen(HTTPS_PORT);

module.exports = { app };