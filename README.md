# sample-node-api  
A sample node js api for finding cars and accounts for a dealership,its used here to demonstrate the steps to extend API/ML with your own rest api.     

## Steps

**Note**  
`Only rest api with https support can be deployed behind API/ML, make sure to enable https support in your rest api.
`   
This sample express app, has https enabled already.    

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
scp -r sample-node-api ibmuser@my.mainframe.com:</usr/lpp/extender>/sample-node-api
```

### 3) Register as External Component  
Append to EXTERNAL_COMPONENT </usr/lpp/extender>/sample-node-api in INSTANCE_DIR/instance.env

```
 vi INSTANCE_DIR/instance.env
 EXTERNAL_COMPONENTS=</usr/lpp/extender>/sample-node-api
```
It expects `bin` folder with `start.sh`, `configure.sh` and `validate.sh`, provide lifecycle hooks to configure and start your api component with rest rest of zowe.

### 4) Access newly deployed webservice behind api/v1         
`https://my.mainframe.com:7554/api/v1/sample-node-api/accounts/`           
`https://my.mainframe.com:7554/api/v1/sample-node-api/accounts/1/`           
`https://my.mainframe.com:7554/api/v1/sample-node-api/accounts/1/cars/`           
