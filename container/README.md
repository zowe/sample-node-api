# Sample-node-api

## General Information

This image can be used to start Sample-node-api.

It includes 2 Linux Distro:

    Ubuntu
    Red Hat UBI

Each image supports both amd64 and s390x CPU architectures.
## Usage

Image zowe-docker-release.jfrog.io/ompzowe/sample-node-api:latest should be able to run with minimal environment variables:

- `KEYSTORE_KEY`: You can supply your own certificate private key
- `KEYSTORE_CERTIFICATE`: You can supply your own certificate
- `MY_API_NAME`: You can supply your API NAme (Default is sample-node-api)
- `MY_API_PORT`: You can supply your own API_PORT (Default is 18000)

Example commands:

```
# pull image
docker pull zowe-docker-release.jfrog.io/ompzowe/sample-node-api:latest
# start container
docker run -it --rm -p 8546:8546 \
    -e KEYSTORE_KEY=<key_location> \
    -e KEYSTORE_CERTIFICATE=<certification_location> \
    zowe-docker-release.jfrog.io/ompzowe/sample-node-api:latest
```