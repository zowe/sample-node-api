/*
  This program and the accompanying materials are
  made available under the terms of the Eclipse Public License v2.0 which accompanies
  this distribution, and is available at https://www.eclipse.org/legal/epl-v20.html
  
  SPDX-License-Identifier: EPL-2.0
  
  Copyright IBM Corporation 2020
*/

const express = require('express');
const http = require('http');
const https = require('https');
const cors = require('cors');

const {buildConfigFromParams} = require('./utils/params');
let config = buildConfigFromParams();
const {https:{key, cert}, port} = config;
const credentials = { key, cert};

const app = express();
app.use(cors());
const routes = require('./routes/index.route');
app.use(routes);

const httpServer = http.createServer(app);
const httpsServer = https.createServer(credentials, app);

httpServer.listen(port);
httpsServer.listen(port+1);
console.log(`http server listening at port ${port}`);
console.log(`https server listening at port ${port + 1}`);

module.exports = { app };