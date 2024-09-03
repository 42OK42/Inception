FROM debian:bullseye

RUN apt-get update && apt-get install -y nginx openssl

COPY nginx-conf/default.conf /etc/nginx/conf.d/default.conf
COPY nginx-ssl /etc/nginx/ssl

CMD ["nginx", "-g", "daemon off;"]