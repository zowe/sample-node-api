#!/bin/sh
NODE_BIN=${NODE_HOME}/bin/node
export __UNTAGGED_READ_MODE=V6
/S0W1/var/nodejs/node-v8.17.0-os390-s390x/bin/node /u/ibmuser/workspace/sample-cli-api/src/index.js --port 17000 &