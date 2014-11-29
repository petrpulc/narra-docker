FROM phusion/passenger-ruby21
MAINTAINER Michal Mocnal <michal@narra.eu>

# Set correct environment variables.
ENV HOME /root
ENV RAILS_ENV production

# Set narra build env
RUN mkdir /build/narra
ADD . /build/narra

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# Build system and git.
RUN /build/utilities.sh

# Databases support support.
RUN /build/redis.sh
RUN /build/narra/mongodb.sh

# Install NARRA
RUN /build/narra/install.sh

# Enable the Mongodb service.
EXPOSE 80 6379 27017

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*