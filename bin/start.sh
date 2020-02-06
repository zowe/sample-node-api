#!/bin/sh

# find node bin
NODE_BIN=${NODE_HOME}/bin/node

#load component config
. env.sh

COMPONENT_DIR="${ROOT_DIR}/components/${MY_API_NAME}"

#start component
$NODE_BIN $COMPONENT_DIR/server/app.js \
  --service ${MY_API_NAME} \
	--port ${MY_API_PORT} \
	--key  ${KEYSTORE_KEY} \
	--cert ${KEYSTORE_CERTIFICATE} \
	-v &