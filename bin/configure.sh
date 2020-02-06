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
iconv -f IBM-1047 -t IBM-850 ${STATIC_DEF_CONFIG_DIR}/${MY_API_NAME}.ebcidic.yml > $STATIC_DEF_CONFIG_DIR/${MY_API_NAME}.yml
rm ${STATIC_DEF_CONFIG_DIR}/${MY_API_NAME}.ebcidic.yml
chmod 770 $STATIC_DEF_CONFIG_DIR/${MY_API_NAME}.yml