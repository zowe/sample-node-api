#!/bin/bash

################################################################################
# This program and the accompanying materials are made available under the terms of the
# Eclipse Public License v2.0 which accompanies this distribution, and is available at
# https://www.eclipse.org/legal/epl-v20.html
#
# SPDX-License-Identifier: EPL-2.0
#
# Copyright Contributors to the Zowe Project.
################################################################################

################################################################################
# prepare docker build context
#
# This script will be executed with 2 parameters:
# - linux-distro
# - cpu-arch

################################################################################
# This script prepares all required files we plan to put into explorer-ip
# image.
#
# Prereqs:
# - must run with Github Actions (with GITHUB_RUN_NUMBER and GITHUB_SHA)
# - must provide $GITHUB_PR_ID is it's pull request
# - jq

# exit if there are errors
set -e

###############################
# check parameters
linux_distro=$1
cpu_arch=$2
if [ -z "${linux_distro}" ]; then
  echo "Error: linux-distro parameter is missing."
  exit 1
fi
if [ -z "${cpu_arch}" ]; then
  echo "Error: cpu-arch parameter is missing."
  exit 1
fi

################################################################################
# CONSTANTS
BASE_DIR=$(cd $(dirname $0);pwd)
REPO_ROOT_DIR=$(cd $(dirname $0)/../;pwd)
WORK_DIR=tmp
JFROG_REPO_SNAPSHOT=libs-snapshot-local
JFROG_REPO_RELEASE=libs-release-local
JFROG_URL=https://zowe.jfrog.io/zowe/

################################
echo ">>>>> prepare basic files"
cd "${REPO_ROOT_DIR}"
package_version=$(jq -r '.version' package.json)
package_release=$(echo "${package_version}" | awk -F. '{print $1;}')


###############################
echo ">>>>> clean up folders"
rm -fr "${BASE_DIR}/${WORK_DIR}"
mkdir -p "${BASE_DIR}/${WORK_DIR}"
rm -fr “${BASE_DIR}/${linux_distro}/${cpu_arch}”

################################
# copy Dockerfile
echo ">>>>> copy Dockerfile to ${linux_distro}/${cpu_arch}/Dockerfile"
cd "${BASE_DIR}"
mkdir -p "${linux_distro}/${cpu_arch}"
if [ ! -f Dockerfile ]; then
  echo "Error: Dockerfile file is missing."
  exit 2
fi
cat Dockerfile | sed -e "s#version=\"0\.0\.0\"#version=\"${package_version}\"#" -e "s#release=\"0\"#release=\"${package_release}\"#" > "${linux_distro}/${cpu_arch}/Dockerfile"


cd "${REPO_ROOT_DIR}"
cp  manifest.yaml "${BASE_DIR}/${WORK_DIR}"
cp  README.md "${BASE_DIR}/${WORK_DIR}"
cp  LICENSE "${BASE_DIR}/${WORK_DIR}"

# build client
echo "[${SCRIPT_NAME}] building client ..."
npm install     
npm run build

# copy sample-node-api to target folder
# copy start script to target folder - included in dist
echo "[${SCRIPT_NAME}] copying sample node api backend ..."
cp -r dist/. "${BASE_DIR}/${WORK_DIR}"

###############################
echo ">>>>> prepare manifest.json"
cd "${REPO_ROOT_DIR}"
if [ -n "${GITHUB_PR_ID}" ]; then
  GITHUB_BRANCH=PR-${GITHUB_PR_ID}
else
  GITHUB_BRANCH=${GITHUB_REF#refs/heads/}
fi

echo "    - branch: ${GITHUB_BRANCH}"
echo "    - build number: ${GITHUB_RUN_NUMBER}"
echo "    - commit hash: ${GITHUB_SHA}"
# assume to run in Github Actions
cat manifest.yaml | \
  sed -e "s#{{build\.branch}}#${GITHUB_BRANCH}#" \
      -e "s#{{build\.number}}#${GITHUB_RUN_NUMBER}#" \
      -e "s#{{build\.commitHash}}#${GITHUB_SHA}#" \
      -e "s#{{build\.timestamp}}#$(date +%s)#" \
  > "${BASE_DIR}/${WORK_DIR}/manifest.yaml"

###############################
# copy to target context
echo ">>>>> copy to target build context"
cp -r "${BASE_DIR}/${WORK_DIR}" "${BASE_DIR}/${linux_distro}/${cpu_arch}/component"

###############################
# done
echo ">>>>> all done"