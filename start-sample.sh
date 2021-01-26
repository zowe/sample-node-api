## start locally
node src/index.js --service sample-node-api --port 8080 --key sslcert/server.key --cert sslcert/server.cert -v

cd ~/zowe/extenders/sample-node-api
## start on z/os uss 
KEYSTORE_DIRECTORY=/u/nakul/zowe/keystore
KEYSTORE_ALIAS=localhost
KEYSTORE_PREFIX="${KEYSTORE_DIRECTORY}/${KEYSTORE_ALIAS}/${KEYSTORE_ALIAS}.keystore"
KEYSTORE_KEY=${KEYSTORE_PREFIX}.key
KEYSTORE_CERTIFICATE=${KEYSTORE_PREFIX}.cer-ebcdic
export __UNTAGGED_READ_MODE=V6
node src/index.js --service sample-node-api --port 18000 --key ${KEYSTORE_KEY} --cert ${KEYSTORE_CERTIFICATE} -v

/usr/lpp/IBM/cnj/v12r0/IBM/node-v12.14.1-os390-s390x/bin/node src/index.js --service jes --path /ui/v1/explorer-jes --dir /u/nakul/zowe/runtime/components/explorer-jes/bin/app --port 48546 --key  ${KEYSTORE_KEY} --cert ${KEYSTORE_CERTIFICATE} --csp tvt5003.svl.ibm.com:*
/usr/lpp/IBM/cnj/v8r0/IBM/node-v8.17.0.1-os390-s390x/bin/node src/index.js --service jes --path /ui/v1/explorer-jes --dir /u/nakul/zowe/runtime/components/explorer-jes/bin/app --port 48546 --key  ${KEYSTORE_KEY} --cert ${KEYSTORE_CERTIFICATE} --csp tvt5003.svl.ibm.com:*

# register with API ML layer
cd ~/zowe/extenders/sample-node-api
iconv -f IBM-1047 -t IBM-850 sample-node-api.yml > ~/zowe/instance/workspace/api-mediation/api-defs/sample-node-api.yml