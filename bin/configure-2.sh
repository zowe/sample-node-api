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

. env.sh
COMPONENT_DIR="${ROOT_DIR}/components/${MY_API_NAME}"

# copy static definition for sample-node-api to make fresh copy on every start
cp ${COMPONENT_DIR}/${MY_API_NAME}.yml ${COMPONENT_DIR}/${MY_API_NAME}.ebcidic.yml

#configure based on env.sh
sed -i 's/mymainframe.ibm.com/${ZOWE_EXPLORER_HOST}/g' ${COMPONENT_DIR}/${MY_API_NAME}.ebcidic.yml
sed -i 's/18000/${MY_API_PORT}/g' ${COMPONENT_DIR}/${MY_API_NAME}.ebcidic.yml

iconv -f IBM-1047 -t IBM-850 ${COMPONENT_DIR}/${MY_API_NAME}.ebcidic.yml > $STATIC_DEF_CONFIG_DIR/${MY_API_NAME}.yml
chmod 770 $STATIC_DEF_CONFIG_DIR/${MY_API_NAME}.yml