#!/bin/sh

# pre-req
# 1. sample-node-api root should be directly under zowe installation directory eg /u/zowe/ibmuser/1.0.1/sample-node-api/
# 2. register-sample-api.sh make this executable chmod 755

echo 'register sample api'
zowe_base_path = '/u/zowe/ibmuser/1.0.1'
api_defs_path = "$zowe_base_path/api-mediation/api-defs"
run_zowe_path = "$zowe_base_path/scripts/internal/run-zowe.sh"

if [ -d $api_defs_path ] 
then 
    echo "Error: Unable to locate $api_defs_path folder"
    exit(1)
fi

if [ -f $run_zowe_path ] 
then 
    echo "Error: Unable to locate $run_zowe_path script"
    exit(1)
fi

echo 'making scripts start/restart script executable'
chmod 755 start-sample-node-api.sh
chmod 755 restart-sample-node-api.sh

echo 'change yaml file from 1047 to 850 format'
iconv -t IBM-850 -f IBM-1047 sample-node-api.yml > sample-node-api.yml.850

echo 'move yaml file to api-defs folder'
mv sample-node-api.yml.850 ${api_defs_path}/sample-node-api.yml

echo 'appending sample api startup script to run-zowe.sh'

if ! grep -q 'start-sample-node-api.sh' "$file_path"; then
`dirname $0`/../../sample-node-api/scripts/start-sample-node-api.sh >> $run_zowe_path
fi

echo 'done'
