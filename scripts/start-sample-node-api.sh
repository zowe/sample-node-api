#!/bin/sh

# find node bin
if [ ! -z "$NODE_HOME" ]; then
  NODE_BIN=${NODE_HOME}/bin/node
else
  echo "Error: cannot find node bin, node app did not start"
  exit 1
fi

# get current script directory
SCRIPT_DIR=$(dirname "$0")

# get to new node app source directory
cd "$SCRIPT_DIR/.."

# start service
$NODE_BIN server/app.js &