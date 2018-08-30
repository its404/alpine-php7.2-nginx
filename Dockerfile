FROM php:7.2-fpm-alpine

WORKDIR /var/www

ENV PHP_XDEBUG_REMOTE_HOST=${PHP_XDEBUG_REMOTE_HOST:-docker.for.win.localhost}
ENV PHP_XDEBUG_IDEKEY=${PHP_XDEBUG_IDEKEY:-XDEBUG_ECLIPSE}
ENV PHP_XDEBUG_REMOTE_ENABLE=${PHP_XDEBUG_REMOTE_ENABLE:-on}

LABEL Maintainer="Ben <ics0425907@gmail.com>"

USER root

RUN apk update && \
    apk add --no-cache bash \
        git \
        freetds \
        freetype \
        icu \
        libintl \
        libldap \
        libjpeg \
        libmcrypt \
        libpng \
        libpq \
        libwebp \
        supervisor \
        nginx \
        nodejs && \
    apk add --no-cache  --virtual  build-dependencies \
        curl-dev \
        freetds-dev \
        freetype-dev \
        gettext-dev \
        icu-dev \
        jpeg-dev \
        libmcrypt-dev \
        libpng-dev \
        libwebp-dev \
        libxml2-dev \
        openldap-dev \
        postgresql-dev \
        zlib-dev \
        autoconf \
        build-base && \
	pecl install xdebug && \
	docker-php-ext-enable xdebug && \
	docker-php-ext-configure gd \
        --with-freetype-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-configure ldap --with-libdir=lib/ && \
    docker-php-ext-configure pdo_dblib --with-libdir=lib/ && \
    docker-php-ext-install \
        curl \
        exif \
        gd \
        gettext \
        opcache \
        pdo_mysql \
        pdo_dblib \
        soap \
        zip && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    apk del build-dependencies && \
    rm -rf /tmp/* 

COPY nginx.conf /etc/nginx/nginx.conf
COPY supervisord.conf /etc/supervisord.conf
COPY xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

CMD ["supervisord", "--nodaemon"]

EXPOSE 80
