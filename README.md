# sample-node-api  
A sample node js api for finding cars and accounts for a dealership,its used here to demonstrate the steps to extend API/ML with your own rest api.     

## Manual Installation 

## Steps

**Note**  
`Only rest api with https support can be deployed behind API/ML, make sure to enable https support in your rest api.
` 


**Note**  
Replace `/u/zowe/ibmuser/1.0.0/` with your zowe installation folder    
Replace `ibmuser@my.mainframe.com` with your username and mainframe-ip    


This sample express app, has https enabled already.    

# Download and transfer project files

### 1) Clone the repository, install node packages  and verify routes locally

``` 
//on local
git clone https://github.com/zowe/sample-node-api
cd sample-node-api
npm install
npm start
```

Open your local browser and try accessing     
`https://localhost:4000/accounts/`   
`https://localhost:4000/accounts/1`   
`https://localhost:4000/accounts/1/cars/`   


### 2) Transfer project files from local to remote host

**Note**  
Don't transfer `node_modules` folder, we can do install npm install later on remote server itself to pull down required node packages

```
// on remote - Create placeholder directory for your node app
ssh ibmuser@my.mainframe.com
cd /u/zowe/ibmuser/1.0.0/
mkdir sample-node-api

```

```
//on local - use scp to transfer project files
scp data.js ibmuser@my.mainframe.com:/u/zowe/ibmuser/1.0.0/sample-node-api
scp package.json ibmuser@my.mainframe.com:/u/zowe/ibmuser/1.0.0/sample-node-api
scp package-lock.json ibmuser@my.mainframe.com:/u/zowe/ibmuser/1.0.0/sample-node-api
scp sample-node-api.yml ibmuser@my.mainframe.com:/u/zowe/ibmuser/1.0.0/sample-node-api/sample-node-api.yml.1047

scp -r scripts ibmuser@my.mainframe.com:/u/zowe/ibmuser/1.0.0/sample-node-api/scripts
scp -r server ibmuser@my.mainframe.com:/u/zowe/ibmuser/1.0.0/sample-node-api/server
scp -r sslcert ibmuser@my.mainframe.com:/u/zowe/ibmuser/1.0.0/sample-node-api/sslcert
```


# Setup and Register API on host

### 1) Install node packages required by project

```
// on remote
cd /u/zowe/ibmuser/1.0.0/sample-node-api
npm install
```

### 2) Modify startup script permission
Change unix permission of start up shell script `start-sample-node-api.sh`, so `run-zowe.sh` script can start a API 

```
// on remote
cd /u/zowe/ibmuser/1.0.0/sample-node-api/scripts
chmod 755 start-sample-node-api.sh
```

### 3) Register a plugin API/ML layer using yml file

**Note**  
Require encoding for `sample-node-api.yml` is `IBM-850`, use `iconv` utility to convert it to correct format  

Yaml config file needs to be present in api-defs folder along-with other statically discovered API example jobs.yml, uss.yml etc

```
// on remote
cd /u/zowe/ibmuser/1.0.0/sample-node-api
iconv -t IBM-850 -f IBM-1047 sample-node-api.yml.1047 > sample-node-api.yml
mv sample-node-api.yml ../api-mediation/api-defs/
```

### 4) Modify zowe startup script to include API startup script
Edit `run-zowe.sh` on remote append node app startup script

```
// on remote
cd /u/zowe/ibmuser/1.0.0/scripts/internal/
vi run-zowe.sh
```
Append following start command for sample-node-api, among similar command from another services

```
`dirname $0`/../../sample-node-api/scripts/start-sample-node-api.sh
```

# Run Project

### 1) Restart Zowe


**Note**  
Replace `ZOWESVR` below with name of your installed zowe instance

from TN3270 terminal
```
# stop/cancel
/c ZOWESVR

# start/restart
/s ZOWESVR
```

Or, we can use zowe helper scripts to restart zowe
```
ssh ibmuser@my.mainframe.com
cd /u/zowe/ibmuser/1.0.0/scripts
./zowe-stop.sh
./zowe-start.sh
```

### 2) Access newly deployed webservice behind api/v1         
`https://my.mainframe.com:7554/api/v1/sample-node-api/accounts/`           
`https://my.mainframe.com:7554/api/v1/sample-node-api/accounts/1/`           
`https://my.mainframe.com:7554/api/v1/sample-node-api/accounts/1/cars/`           



