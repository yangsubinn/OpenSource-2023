FROM ubuntu:20.04

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_RUN_DIR /var/www/html
ENV DEBIAN_FRONTEND=noninteractive


RUN apt-get update && apt-get -y install build-essential && apt-get install -y apache2 && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    # mkdir -p /app \
    # mkdir -p /var/www/html/css && \
    # mkdir -p /var/www/html/js && \
    # mkdir -p /var/www/html/assets
    
# COPY . /app/
COPY . /var/www/html
WORKDIR /var/www/html

# COPY ./index.html /var/www/html/index.html
# COPY css /var/www/html/css
# COPY js /var/www/html/js
# COPY assets /var/www/html/assets

# RUN cat index.html > /var/www/html/index.html
# COPY css /var/www/html
# COPY ./js /var/www/html
# COPY ./assets /var/www/html

ENTRYPOINT ["/usr/sbin/apache2"]
CMD ["-D", "FOREGROUND"]
