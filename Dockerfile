# docker build 
FROM php:8.0.8-fpm

RUN apt-get update -y \ 
    && apt-get install -y nginx wget
    
RUN wget https://github.com/planetscale/cli/releases/download/v0.52.0/pscale_0.52.0_linux_amd64.deb \
    && dpkg -i pscale_0.52.0_linux_amd64.deb

COPY /app/frontend /var/www

COPY /nginx/conf.d/site.conf /etc/nginx/conf.d/site.conf 
COPY /nginx/conf.d/site.conf /etc/nginx/sites-enabled/default
COPY entrypoint.sh /var/app/entrypoint.sh

RUN chmod -R 777 /var/app/entrypoint.sh
RUN sed -i -e 's/\r$//' /var/app/entrypoint.sh

WORKDIR /var/www

EXPOSE 80

ENTRYPOINT ["sh", "/var/app/entrypoint.sh"]
