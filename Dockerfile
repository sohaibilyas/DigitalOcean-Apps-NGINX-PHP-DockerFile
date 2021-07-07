FROM php:8.0.8-fpm

RUN apt-get update -y \ 
    && apt-get install -y nginx

COPY /app/frontend /var/www/
COPY /app/backend /var/app/backend

COPY /nginx/conf.d/site.conf /etc/nginx/conf.d/site.conf 
COPY /nginx/conf.d/site.conf /etc/nginx/sites-enabled/default
COPY entrypoint.sh /var/app/entrypoint.sh

RUN chmod -R 777 /var/app/entrypoint.sh
RUN sed -i -e 's/\r$//' /var/app/entrypoint.sh

# Switch to use a non-root user from here on
USER nobody

WORKDIR /var/www

EXPOSE 8080

ENTRYPOINT ["sh", "/var/app/entrypoint.sh"]
