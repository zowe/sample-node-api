#!/bin/sh

################################################################################
# This program and the accompanying materials are made available under the terms of the
# Eclipse Public License v2.0 which accompanies this distribution, and is available at
# https://www.eclipse.org/legal/epl-v20.html
#
# SPDX-License-Identifier: EPL-2.0
#
# Copyright IBM Corporation 2018, 2019
################################################################################

################################################################################
# start sample node api
# 
# NOTE: this script is intended to be called by ZOWE service, not manually by .

# find node bin
if [ ! -z "$NODE_HOME" ]; then
  NODE_BIN=${NODE_HOME}/bin/node
else
  echo "Error: cannot find node bin, JES Explorer UI is not started."
  exit 1
fi
# get current script directory
SCRIPT_DIR=$(dirname "$0")
# get current ui server directory
SERVER_DIR=$(cd "$SCRIPT_DIR/.."; pwd)

# start service
$NODE_BIN npm run start &