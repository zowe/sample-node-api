#######################################################################
# This program and the accompanying materials are made available
# under the terms of the Eclipse Public License v2.0 which
# accompanies this distribution, and is available at
# https://www.eclipse.org/legal/epl-v20.html
#
# SPDX-License-Identifier: EPL-2.0
#
# Copyright Contributors to the Zowe Project.
#######################################################################

# base image tag
ARG ZOWE_BASE_IMAGE=latest-ubuntu

FROM zowe-docker-release.jfrog.io/ompzowe/base-node:${ZOWE_BASE_IMAGE} AS builder

##################################
# labels
LABEL name="sample-node-api" \
      maintainer="kajank@ca.ibm.com" \
      vendor="Zowe" \
      version="0.0.0" \
      release="0" \
      summary="A sample node js api api" \
      description="It is used to demonstrate the steps to extend API/ML with your own rest api."

##################################
# switch context
USER zowe
WORKDIR /component

##################################
# copy files
COPY --chown=zowe:zowe component .
COPY --chown=zowe:zowe component/LICENSE /licenses

##################################
# build component
RUN npm install --only=prod

# start command
EXPOSE 18000
ENTRYPOINT [ "bin/start.sh" ]