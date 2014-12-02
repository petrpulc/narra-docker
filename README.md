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

#### `narra-mongo.service`
```ini
[Unit]
Description=MongoDB server for NARRA instance
After=docker.service
Requires=docker.service

[Service]
TimeoutStartSec=0
ExecStartPre=-/usr/bin/docker kill narra-mongo
ExecStartPre=-/usr/bin/docker rm narra-mongo
ExecStartPre=/usr/bin/docker pull mongo
ExecStart=/usr/bin/docker run --name narra-mongo mongo
ExecStop=/usr/bin/docker stop narra-mongo

[X-Fleet]
MachineMetadata=type=master
Conflicts=narra-mongo*
```

#### `narra-redis.service`
```ini
[Unit]
Description=Redis server for NARRA instance
After=docker.service
Requires=docker.service

[Service]
TimeoutStartSec=0
ExecStartPre=-/usr/bin/docker kill narra-redis
ExecStartPre=-/usr/bin/docker rm narra-redis
ExecStartPre=/usr/bin/docker pull redis
ExecStart=/usr/bin/docker run --name narra-redis redis
ExecStop=/usr/bin/docker stop narra-redis

[X-Fleet]
MachineMetadata=type=master
Conflicts=narra-redis*
```

#### `narra-master.service`
```ini
[Unit]
Description=NARRA instance master node
After=narra-mongo.service
Requires=narra-mongo.service
After=narra-redis.service
Requires=narra-redis.service

[Service]
TimeoutStartSec=0
ExecStartPre=-/usr/bin/docker kill narra-master
ExecStartPre=-/usr/bin/docker rm narra-master
ExecStartPre=/usr/bin/docker pull narra/master
ExecStart=/usr/bin/docker run --name narra-master --rm -p 80:80 --link narra-mongo:mongo --link narra-redis:redis narra/master
ExecStop=/usr/bin/docker stop narra-master

[X-Fleet]
MachineMetadata=type=master
Conflicts=narra-master*
```

#### `narra-worker.service`
```ini
[Unit]
Description=NARRA instance worker node
After=narra-master.service
Requires=narra-master.service

[Service]
TimeoutStartSec=0
ExecStartPre=-/usr/bin/docker kill narra-worker
ExecStartPre=-/usr/bin/docker rm narra-worker
ExecStartPre=/usr/bin/docker pull narra/worker
ExecStart=/usr/bin/docker run --name narra-worker --rm --link narra-mongo:mongo --link narra-redis:redis narra/worker
ExecStop=/usr/bin/docker stop narra-worker

[X-Fleet]
MachineMetadata=type=worker
```
