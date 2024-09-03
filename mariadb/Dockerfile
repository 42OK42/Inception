FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server

RUN mkdir -p /var/lib/mysql /run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql /run/mysqld

COPY init.sql /docker-entrypoint-initdb.d/

CMD ["mysqld"]