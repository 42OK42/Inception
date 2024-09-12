# base image
FROM debian:bullseye

RUN mkdir -p /var/www/wordpress

# update package manager
RUN apt-get update -y && apt-get upgrade -y

# install packages
RUN apt-get install -y wget php php7.4-fpm php-mysql mariadb-client curl netcat-traditional
# sendmail

# clean up cached package files
RUN rm -rf /var/lib/apt/lists/

# copy WordPress config script into container
COPY tools/wordpress_conf.sh /usr/local/bin/wordpress_conf.sh

# change executable rights of database creation script
RUN chmod +x /usr/local/bin/wordpress_conf.sh

# define WordPress config script to run when container starts
ENTRYPOINT ["/usr/local/bin/wordpress_conf.sh"]