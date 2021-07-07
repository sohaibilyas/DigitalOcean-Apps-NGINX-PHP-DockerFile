# docker build 
FROM php:8.0-fpm

RUN apt-get update -y \ 
    && apt-get install -y nginx

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
COPY --from=planetscale/pscale:latest /usr/bin/pscale /usr/local/bin/pscale

COPY /app/frontend /var/www

COPY /nginx/conf.d/site.conf /etc/nginx/conf.d/site.conf 
COPY /nginx/conf.d/site.conf /etc/nginx/sites-enabled/default
COPY entrypoint.sh /var/app/entrypoint.sh

RUN chmod -R 777 /var/app/entrypoint.sh
RUN sed -i -e 's/\r$//' /var/app/entrypoint.sh

WORKDIR /var/www

EXPOSE 80

#ENTRYPOINT ["sh", "/var/app/entrypoint.sh"]
