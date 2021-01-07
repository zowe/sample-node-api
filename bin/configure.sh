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
# STATIC_DEF_CONFIG_DIR=${INSTANCE_DIR}/workspace/api-mediation/api-defs
# ZOWE_EXPLORER_HOST
# MY_API_NAME
# MY_API_PORT

echo 'sample-node-api configure begin'

echo "LAUNCH_COMPONENT: ${LAUNCH_COMPONENT} "
COMPONENT_DIR=$(dirname "${LAUNCH_COMPONENT}")
echo "COMPONENT_DIR: ${COMPONENT_DIR}"

# load config from env
echo 'load sample-node-api config'
. ${COMPONENT_DIR}/bin/env.sh

echo 'sample-node-api configure done'
