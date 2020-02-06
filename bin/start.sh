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