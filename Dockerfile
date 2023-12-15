FROM ubuntu:20.04

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_RUN_DIR /var/www/html
ENV DEBIAN_FRONTEND=noninteractive


RUN apt-get update && apt-get -y install build-essential && apt-get install -y apache2 && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone 
RUN echo "AddType text/css .css" >> /etc/apache2/apache2.conf && \
    echo "AddType text/javascript .js" >> /etc/apache2/apache2.conf
RUN sed -i 's/AllowOverride None/AllowOVerride All/g' /etc/apache2/apache2.conf
COPY . /var/www/html
WORKDIR /var/www/html

ENTRYPOINT ["/usr/sbin/apache2"]
CMD ["-D", "FOREGROUND"]
