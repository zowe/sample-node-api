## start locally
node server/app.js --service sample-node-api --port 8080 --key sslcert/server.key --cert sslcert/server.cert -v

## start on z/os uss 
KEYSTORE_DIRECTORY=/u/nakul/zowe/keystore
KEYSTORE_ALIAS=localhost
KEYSTORE_PREFIX="${KEYSTORE_DIRECTORY}/${KEYSTORE_ALIAS}/${KEYSTORE_ALIAS}.keystore"
KEYSTORE_KEY=${KEYSTORE_PREFIX}.key
KEYSTORE_CERTIFICATE=${KEYSTORE_PREFIX}.cer-ebcdic
node server/app.js --service sample-node-api --port 19000 --key ${KEYSTORE_KEY} --cert ${KEYSTORE_CERTIFICATE} -v