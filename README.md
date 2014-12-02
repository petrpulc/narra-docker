![narra logo](narra.png)
A Docker base images for NARRA deployment
=========================================

---------------------------------------

**Table of contents**

 * [MongoDB and Redis](#mongodb_and_redis)
 * [Environment variables](#environment)
 * [Deployment](#deployment)
 * [Deployment into a CoreOS cluster](#deployment_coreos)

---------------------------------------

<a name="mongodb_and_redis"></a>
### MongoDB and Redis

    docker run --name narra-mongo -d mongo
    docker run --name narra-redis -d redis
<a name="environment"></a>
### Environment variables

#### `NARRA_INSTANCE_NAME`

Site unique instance name. It should be unique for the same storage account.

#### `NARRA_AWS_ACCESS_KEY` optional

Amazon AWS Access Credentials

#### `NARRA_AWS_SECRET` optional

Amazon AWS Access Credentials

#### `NARRA_AWS_REGION` optional

Amazon AWS region `eu-west-1`

<a name="deployment"></a>
### Deployment

    docker run -rm -p 80:80 --link narra-mongo:mongo --link narra-redis:redis -d narra/master
    docker run -rm --link narra-mongo:mongo --link narra-redis:redis -d narra/worker
    
To push environment variables into a container it is neccessary to run the container with `-e` option

    docker run -e NARRA_INSTANCE_NAME=... -e NARRA_AWS_ACCESS_KEY=...
    
<a name="deployment_coreos"></a>    
### Deployment into a CoreOS cluster
