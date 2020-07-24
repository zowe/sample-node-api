# sample-node-api  
A sample node js api for finding cars and accounts for a dealership,its used here to demonstrate the steps to extend API/ML with your own rest api.     

## Steps

**Note**  
`Only rest api with https support can be deployed behind API/ML, make sure to enable https support in your rest api.
`   
This sample express app, has https enabled already.    

## PART I: Download & Build on local

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
cd sample-node-api
npm run build
scp -r dist ibmuser@my.mainframe.com:</usr/lpp/extender>/sample-node-api
```

## PART II: Deploy with Zowe on server

### 1) login
```  
ssh ibmuser@my.mainframe.com       
```

### 2) install dependencies    
```
cd </usr/lpp/extender>/sample-node-api        
npm install --only=prod       

```

### 3) Manage lifecycle of service with core zowe components

Use property `EXTERNAL_COMPONENTS` located in file `$INSTANCE_DIR/instance.env`       
Append it (comma separated) with the directory containing your service lifecycle scripts.

In our sample it is:   
```
 vi INSTANCE_DIR/instance.env   
 EXTERNAL_COMPONENTS=</usr/lpp/extender>/sample-node-api/bin      
```

We expect following in service folder `start.sh`, `configure.sh` and `validate.sh`.
In our case its bin folder with relevant scripts.    
    
`configure.sh` it adds static definition for sample-node-api to folder ${INSTANCE_DIR}/workspace/api-mediation/api-defs in IBM-850 encoding     
`start.sh` starts node app on configured port       
`env.sh` its custom script use to configure port for our node app, feel free to use your desired way         

### 4) Access newly deployed webservice

Please see static definition file `sample-node-api.yml`      
It configures service endpoint as `sample-node-api` with property `serviceId`     
We also provide api gateway base path `api\v1` with property `gatewayUrl` in same file.        


In effect, service can be accessed with following url:      
`https://{host}:{GATEWAY_PORT}/{gatewayUrl}/{serviceId}/*`    

where `GATEWAY_PORT` is configured in $INSTANCE_DIR/instance.env      

Verify by accessing following:      
`https://my.mainframe.com:7554/api/v1/sample-node-api/accounts/`            
`https://my.mainframe.com:7554/api/v1/sample-node-api/accounts/1/`            
`https://my.mainframe.com:7554/api/v1/sample-node-api/accounts/1/cars/`              

### 5) Registered With API Catalog

**API Catalog**
![APICatalog_Dashboard](./screenshots/APICatalog_Dashboard.png)

![ApiCatalog_SampleNodeApi_SwaggerDoc](./screenshots/ApiCatalog_SampleNodeApi_SwaggerDoc.png)

**Discovery Service Dashboard**
![DiscoveryService_Dashboard](./screenshots/DiscoveryService_Dashboard.png)
