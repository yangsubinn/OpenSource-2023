FROM ubuntu:20.04
RUN apt-get update && apt-get -y install build-essential && apt-get install -y apache2 && mkdir -p /app
COPY . /app/
WORKDIR /app/

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_RUN_DIR /var/www/html

RUN echo 'Hello, subin' > /var/www/index.html

ENTRYPOINT ["/usr/sbin/apache2"]
CMD ["apache2ctl", "-D", "FOREGROUND"]
