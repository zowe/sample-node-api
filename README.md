# sample-node-api  
A sample node js api for finding cars and accounts for a dealership,its used here to demonstrate the steps to extend API/ML with your own rest api.     

## Manual Installation 

## Steps

**Note**  
`Only rest api with https support can be deployed behind API/ML, make sure to enable https support in your respective api.
` 


**Note**  
Replace `/u/zowe/ibmuser/1.0.0/` with your zowe installation folder    
Replace `ibmuser@my.mainframe.com` with your username and mainframe-ip    


This sample express app, has https enabled already.    

1) Clone the repository, install node packages  and verify routes locally

``` 
git clone https://github.com/zowe/sample-node-api
cd sample-node-api
npm install
npm start
```

Open your local browser and try accessing     
`https://localhost:4000/accounts/`   
`https://localhost:4000/accounts/1`   
`https://localhost:4000/accounts/1/cars/`   

2) Transfer yaml from local to host, to register a plugin API/ML layer

```
scp sample-node-api.yaml ibmuser@my.mainframe.com:/u/zowe/ibmuser/1.0.0/api-mediation/api-defs
```

3) create placeholder directory for your node app  

```
ssh ibmuser@my.mainframe.com
mkdir sample-node-api

```

4) Transfer of file from local to remote host
```
scp data.js ibmuser@my.mainframe.com:/u/zowe/ibmuser/1.0.1/sample-node-api
scp package.json ibmuser@my.mainframe.com:/u/zowe/ibmuser/1.0.1/sample-node-api
scp package-lock.json ibmuser@my.mainframe.com:/u/zowe/ibmuser/1.0.1/sample-node-api


scp -r scripts ibmuser@my.mainframe.com:/u/zowe/ibmuser/1.0.1/sample-node-api/scripts
scp -r server ibmuser@my.mainframe.com:/u/zowe/ibmuser/1.0.1/sample-node-api/server
scp -r sslcert ibmuser@my.mainframe.com:/u/zowe/ibmuser/1.0.1/sample-node-api/sslcert
```

4) ssh again, to edit `run-zowe.sh` 

```
ssh ibmuser@my.mainframe.com
cd /u/zowe/ibmuser/1.0.0/scripts/internal/
vi run-zowe.sh
```

5) Append following start command for sample-node-api, among simillar command from another services

```
`dirname $0`/../../sample-node-api/scripts/start-sample-node-api.sh
```

6) Restart Zowe

7) Access newly deployed webservice behind api/v1         
`https://my.mainframe.com:7554/api/v1/node-sample-api/accounts/`           
`https://my.mainframe.com:7554/api/v1/node-sample-api/accounts/1/`           
`https://my.mainframe.com:7554/api/v1/node-sample-api/accounts/1/cars/`           



