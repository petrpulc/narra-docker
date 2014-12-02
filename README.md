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

    docker run -d --name mongodb -p 27017:27017 dockerfile/mongodb
    docker run -d --name redis -p 6379:6379 dockerfile/redis

<a name="environment"></a>
### Environment variables

#### `NARRA_INSTANCE_NAME`

Site unique instance name. It should be unique for the same storage account.

#### `NARRA_MONGOID`

MongoDB server url in the format `hostname:port`

#### `NARRA_REDIS`

Redis server url in the format `hostname:port`

#### `NARRA_AWS_ACCESS_KEY` optional

Amazon AWS Access Credentials

#### `NARRA_AWS_SECRET` optional

Amazon AWS Access Credentials

#### `NARRA_AWS_REGION` optional

Amazon AWS region `eu-west-1`

<a name="deployment"></a>
### Deployment

    docker run -rm -p 80:80 narra/master
    docker run -rm narra/worker
    
To push environment variables into a container it is neccessary to run the container with `-e` option

    docker run -rm -p 80:80 -e NARRA_INSTANCE_NAME="..." -e NARRA_MONGOID="..." narra/master
    
<a name="deployment_coreos"></a>    
### Deployment into a CoreOS cluster
