![narra logo](narra.png)
A Docker base images for NARRA deployment
=========================================

### MongoDB and Redis

    docker run -d --name mongodb -p 27017:27017 dockerfile/mongodb
    docker run -d --name redis -p 6379:6379 dockerfile/redis

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

### Deployment

    docker run -rm -p 80:80 narra/master
    docker run -rm narra/worker
