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
const fs = require('fs');
const path = require("path");

const cors = require('cors')

function buildConfig(argv) {

  const config = {
    'port': argv.port /*|| port*/,
    'https': {
      'key': argv.key /*|| key*/,
      'cert': argv.cert /*|| cert*/,
      'pfx': argv.pfx,
      'passphrase': argv.pass,
    }
  };
  return config;
}

function loadCertificateFiles(config) {
  // load https certs file content
  if (config && config.https) {
    ['key', 'cert', 'pfx'].forEach(key => {
      if (config.https[key]) {
        let file = config.https[key];
        config.https[key] = fs.readFileSync(file);
      }
    });
  }
  return config;
};

function validateParams (argv) {
  let isValid = true;
  const serviceFor=argv.s;

  if((argv.p==='' || !argv.p) && isValid) {
    isValid = false;
    process.stderr.write(`[${serviceFor}] port configuration is missing\n`);
  }

  if( (argv.k==='' && argv.c==='' && argv.x==='' && argv.w==='') && isValid) {
    isValid = false;
    process.stderr.write(`[${serviceFor}] https configuration is missing\n`);
  }

  if( ( (argv.k==='' && argv.c>'') || (argv.k>'' && argv.c==='')
      || (argv.x==='' && argv.w>'' && argv.k==='' && argv.c==='')
      || (argv.x==='' && argv.w>'' && !(argv.k>'' && argv.c>'')) 
      || (argv.x>'' && argv.w==='') ) && isValid) {
    isValid = false;
    process.stderr.write(`[${serviceFor}] https configuration is missing\n`);
  }

  if(!isValid) {
    process.stderr.write(`[${serviceFor}] is failed to start, error:\n`);
    process.exit(1);
    return false;
  }

  return true;
}

var argv = require('yargs')
  .usage('Usage: $0 [options]')
  .option('s', {
    alias: 'service',
    description: 'service-for path',
    default: ''
  })
  .option('p', {
    alias: 'port',
    description: 'listening port'
  })
  .option('k', {
    alias: 'key',
    default: '',
    description: 'server key'
  })
  .option('c', {
    alias: 'cert',
    default: '',
    description: 'server cert',
  })
  .option('x', {
    alias: 'pfx',
    default: '',
    description: 'server pfx',
  })
  .option('w', {
    alias: 'pass',
    default: '',
    description: 'server pfx passphrase',
  })
  .option('v', {
    alias: 'verbose',
    default: false,
    description: 'show request logs',
    type: 'boolean'
  })
  .help('h')
  .alias('h', 'help')
  .check(validateParams)
  .argv;

let config = buildConfig(argv);
config = loadCertificateFiles(config);
const {https:{key, cert}} = config;
const credentials = { key, cert };



const app = express();

//TODO: use for whitelist only
app.use(cors());
const routes = require('./routes/index.route');

app.get('/', (req, res) => res.send('Hello World!'));
app.use(routes);

// const httpServer = http.createServer(app);
const httpsServer = https.createServer(credentials, app);

// httpServer.listen(HTTP_PORT);
httpsServer.listen(config.port);
console.log(`server listening at port ${config.port}`);

module.exports = { app };