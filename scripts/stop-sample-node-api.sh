#!/bin/sh

echo 'stopping sample node api...'
ps -elf | awk '/node/ && /app.js/ && !/sh -c/' | awk '{print $2}' | xargs kill -9 $1
echo 'stop sample node api done'