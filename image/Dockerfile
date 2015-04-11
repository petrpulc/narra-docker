FROM phusion/passenger-ruby21
MAINTAINER Michal Mocnal <michal@narra.eu>

# Set correct environment variables.
ENV HOME /root
ENV RAILS_ENV production

# Set narra build env
RUN mkdir -p /build/narra
ADD . /build/narra

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# Install NARRA
RUN /build/narra/install.sh

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
