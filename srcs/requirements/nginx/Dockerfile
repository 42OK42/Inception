# base image
FROM debian:bullseye

# update package manager
RUN apt-get update -y && apt-get upgrade -y

# install nginx and openssl
RUN apt-get install -y nginx openssl

# clean up cached package files
RUN rm -rf /var/lib/apt/lists/*

# copy custom NGINX config file into container
COPY conf/nginx.conf /etc/nginx/nginx.conf

# SSL setup
RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/inception.key -out /etc/nginx/ssl/inception.crt \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=okrahl.42.fr"

# expose HTTPS port
EXPOSE 443

# start nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]