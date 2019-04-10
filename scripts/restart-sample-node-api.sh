#!/bin/sh

echo 'restarting sample node api...'
# ps -elf | awk '/node/ && /app.js/ && !/sh -c/' | awk '{print $2}' | xargs kill -9 $1
ps -elf | awk '/node/ && /app.js/ && !/sh -c/' | awk '{print $3}' | xargs kill -9 $1
./start-sample-node-api.sh
sleep 30
echo 'restart sample node api done'