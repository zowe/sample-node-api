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

echo 'load sample-node-api config'
# load config from env
. ${COMPONENT_DIR}/bin/env.sh

echo 'make sample-node-api.ebcidic.yml with replaced env variable'

# Add static definition for sample-node-api
cat <<EOF >${STATIC_DEF_CONFIG_DIR}/${MY_API_NAME}.ebcidic.yml
#
services:
    - serviceId: ${MY_API_NAME}
      title: ${MY_API_NAME}
      description: Example ${MY_API_NAME} Application
      catalogUiTileId: ${MY_API_NAME}
      instanceBaseUrls:
        - https://${ZOWE_EXPLORER_HOST}:${MY_API_PORT}/
      homePageRelativeUrl:  # Home page is at the same URL
      routedServices:
        - gatewayUrl: api/v1  # [api/ui/ws]/v{majorVersion}
          serviceRelativeUrl:
      apiInfo:
        - apiId: com.ibm.${MY_API_NAME}
          gatewayUrl: api/v1
          version: 0.0.1

catalogUiTiles:
    ${MY_API_NAME}:
      title: ${MY_API_NAME}
      description: Example ${MY_API_NAME} Application
EOF

echo 'change sample-node-api.ebcidic.yml encoding from ibm-1047 to ibm-850'

# basically this yml file is only thing we need to do register our service with apiml
iconv -f IBM-1047 -t IBM-850 ${STATIC_DEF_CONFIG_DIR}/${MY_API_NAME}.ebcidic.yml > $STATIC_DEF_CONFIG_DIR/${MY_API_NAME}.yml
rm ${STATIC_DEF_CONFIG_DIR}/${MY_API_NAME}.ebcidic.yml
chmod 770 $STATIC_DEF_CONFIG_DIR/${MY_API_NAME}.yml

echo 'sample-node-api configure done'