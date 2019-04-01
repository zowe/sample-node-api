#!/bin/sh

# find node bin
# export NODE_HOME=/usr/lpp/IBM/cnj/IBM/node-v6.14.4-os390-s390x 
# export NODE_HOME=/usr/lpp/IBM/cnj/IBM/node-v6.14.4-os390-s390x
if [ ! -z "$NODE_HOME" ]; then
  NODE_BIN=${NODE_HOME}/bin/node
  NPM_CLI=${NODE_HOME}/lib/node_modules/npm/bin/npm-cli.js
else
  echo "Error: cannot find node bin, node app did not start"
  exit 1
fi

# get current script directory
SCRIPT_DIR=$(dirname "$0")

# get to new node app source directory
cd "$SCRIPT_DIR/.."

# start service
$NODE_BIN $NPM_CLI run start > sample-node-api.log &