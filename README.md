![narra logo](narra.png)
A Docker base images for NARRA deployment
=========================================

### MongoDB and Redis

    docker run -d --name mongodb -p 27017:27017 dockerfile/mongodb
    docker run -d --name redis -p 6379:6379 dockerfile/redis

### Environment variables

    env NARRA_INSTANCE_NAME;
    env NARRA_MONGOID;
    env NARRA_REDIS;
    env NARRA_AWS_ACCESS_KEY;
    env NARRA_AWS_SECRET;
    env NARRA_AWS_REGION;

### Deployment

    docker run -rm -p 80:80 narra/master
    docker run -rm narra/worker
