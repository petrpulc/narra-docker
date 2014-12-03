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

Amazon AWS region eg. `eu-west-1`

<a name="deployment"></a>
### Deployment

    docker run --rm -p 80:80 --link narra-mongo:mongo --link narra-redis:redis narra/master
    docker run --rm --link narra-mongo:mongo --link narra-redis:redis narra/worker
    
To push environment variables into a container it is neccessary to run the container with `-e` option

    docker run -e NARRA_INSTANCE_NAME=... -e NARRA_AWS_ACCESS_KEY=...
    
<a name="deployment_coreos"></a>    
### Deployment into a CoreOS cluster

Environment variables in files `narra-master@.service` and `narra-worker@.service` have to be properly setup before deployment.

#### Submit services

	fleetctl submit narra-mongo.service
	fleetctl submit narra-redis.service
	fleetctl submit narra-master@.service
	fleetctl submit narra-worker@.service

#### Start services

	fleetctl start narra-mongo
	fleetctl start narra-redis
	fleetctl start narra-master@1
	fleetctl start narra-worker@1
	fleetctl start narra-worker@2

#### Check running services
```
fleetctl list-units

UNIT 						MACHINE						ACTIVE		SUB
narra-master@1.service		d1705fe1.../10.133.223.138	active		running
narra-mongo.service			0418e940.../10.133.223.139	active		running
narra-redis.service			0418e940.../10.133.223.139	active		running
narra-worker@1.service		50b7971e.../10.133.223.136	active		running
narra-worker@2.service		2e66e927.../10.133.220.237	active 		running
```