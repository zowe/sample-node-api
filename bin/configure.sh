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

BASE_DIR=$(dirname "$0")
COMPONENT_DIR="$( cd "${BASE_DIR}/.." >/dev/null 2>&1 && pwd )"
cd $OLDPWD
echo "COMPONENT_DIR: ${COMPONENT_DIR}"

# load config from env
echo 'load sample-node-api config'
. ${COMPONENT_DIR}/bin/env.sh

echo 'Add static definition for sample-node-api'
#configure based on env.sh
sed -e "s/mymainframe.ibm.com/${ZOWE_EXPLORER_HOST}/g" \
    -e "s/18000/${MY_API_PORT}/g" \
    ${COMPONENT_DIR}/${MY_API_NAME}.yml \
    > ${STATIC_DEF_CONFIG_DIR}/${MY_API_NAME}.ebcidic.yml

echo 'change sample-node-api.ebcidic.yml encoding from ibm-1047 to ibm-850'
# basically this yml file is only thing we need to do register our service with apiml
iconv -f IBM-1047 -t IBM-850 ${STATIC_DEF_CONFIG_DIR}/${MY_API_NAME}.ebcidic.yml > $STATIC_DEF_CONFIG_DIR/${MY_API_NAME}.yml
rm ${STATIC_DEF_CONFIG_DIR}/${MY_API_NAME}.ebcidic.yml
chmod 770 $STATIC_DEF_CONFIG_DIR/${MY_API_NAME}.yml

echo 'sample-node-api configure done'
