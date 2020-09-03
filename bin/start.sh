#!/bin/sh

################################################################################
# This program and the accompanying materials are made available under the terms of the
# Eclipse Public License v2.0 which accompanies this distribution, and is available at
# https://www.eclipse.org/legal/epl-v20.html
#
# SPDX-License-Identifier: EPL-2.0
#
# Copyright IBM Corporation 2020
################################################################################

# Variables required on shell:
# NODE_HOME
# MY_API_NAME
# MY_API_PORT
# KEYSTORE_KEY
# KEYSTORE_CERTIFICATE

echo 'sample-node-api start begin'

# find node bin
NODE_BIN=${NODE_HOME}/bin/node

echo "LAUNCH_COMPONENT: ${LAUNCH_COMPONENT} "
COMPONENT_DIR=$(dirname "${LAUNCH_COMPONENT}")
echo "COMPONENT_DIR: ${COMPONENT_DIR}"

# load config from env
echo 'load sample-node-api config'
. ${COMPONENT_DIR}/bin/env.sh

echo "start sample-node-api app on port ${MY_API_PORT}"
#start component
$NODE_BIN $COMPONENT_DIR/src/index.js \
  --service ${MY_API_NAME} \
	--port ${MY_API_PORT} \
	--key  ${KEYSTORE_KEY} \
	--cert ${KEYSTORE_CERTIFICATE} \
	-v &

echo 'sample-node-api start done'
