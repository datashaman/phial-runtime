FROM datashaman/phial-runtime:build-base AS base

ARG PHP_PACKAGE

RUN yum-config-manager --enable remi-${PHP_PACKAGE}

RUN yum update -y \
    && yum install -y \
        ${PHP_PACKAGE} \
        ${PHP_PACKAGE}-php-apcu \
        ${PHP_PACKAGE}-php-gd \
        ${PHP_PACKAGE}-php-mbstring \
        ${PHP_PACKAGE}-php-mysqlnd \
        ${PHP_PACKAGE}-php-opcache \
        ${PHP_PACKAGE}-php-process \
        ${PHP_PACKAGE}-php-xml \
        unzip \
    && ln -s /usr/bin/${PHP_PACKAGE} /usr/bin/php \
    && yum clean all \
    && rm -rf /var/cache/yum

RUN curl https://raw.githubusercontent.com/composer/getcomposer.org/master/web/installer \
    | php -- --quiet --install-dir=/usr/local/bin --filename=composer \
    && composer global require hirak/prestissimo \
    && composer clear-cache

RUN mkdir -p /opt/${PHP_PACKAGE}/etc \
    && cp -a \
        ${PHP_PACKAGE_ROOT}/etc/opt/remi/${PHP_PACKAGE}/{php.d,php.ini} \
        /opt/${PHP_PACKAGE}/etc

RUN mkdir /opt/${PHP_PACKAGE}/lib \
    && cp -a \
        /usr/lib64/libedit.so* \
        /usr/lib64/libexslt.so* \
        /usr/lib64/libfontconfig.so* \
        /usr/lib64/libfreetype.so* \
        /usr/lib64/libfribidi.so* \
        /usr/lib64/libgd.so* \
        /usr/lib64/libgraphite2.so* \
        /usr/lib64/libharfbuzz.so* \
        /usr/lib64/libjbig.so* \
        /usr/lib64/libjpeg.so* \
        /usr/lib64/libncurses.so* \
        /usr/lib64/libonig.so* \
        /usr/lib64/libpcre.so* \
        /usr/lib64/libpng* \
        /usr/lib64/libraqm.so* \
        /usr/lib64/libtinfo.so* \
        /usr/lib64/libtiff.so* \
        /usr/lib64/libwebp.so* \
        /usr/lib64/libX11.so* \
        /usr/lib64/libXau.so* \
        /usr/lib64/libxcb.so* \
        /usr/lib64/libXpm.so* \
        /usr/lib64/libxslt* \
        /opt/${PHP_PACKAGE}/lib

ARG PHP_PACKAGE_ROOT=/opt/remi/${PHP_PACKAGE}/root

RUN mkdir /opt/${PHP_PACKAGE}/bin \
    && cp \
        ${PHP_PACKAGE_ROOT}/bin/php \
        /usr/local/bin/composer \
        /opt/${PHP_PACKAGE}/bin

RUN mkdir /opt/${PHP_PACKAGE}/lib/php \
    && cp -a \
        ${PHP_PACKAGE_ROOT}/usr/lib64/php/modules \
        /opt/${PHP_PACKAGE}/lib/php

RUN sed -i "s#/etc/opt/remi/${PHP_PACKAGE}#/opt/${PHP_PACKAGE}/etc#" "/opt/${PHP_PACKAGE}/etc/php.ini"
# RUN echo "extension_dir=/opt/${PHP_PACKAGE}/lib/php/modules" > /opt/${PHP_PACKAGE}/etc/php.d/phial.ini

FROM datashaman/phial-runtime:build-base

ARG PHP_PACKAGE

ENV COMPOSER_CACHE_DIR=/tmp/composer
ENV HOME="/tmp"
ENV LD_LIBRARY_PATH="/opt/${PHP_PACKAGE}/lib:$LD_LIBRARY_PATH"
ENV PATH="/opt/${PHP_PACKAGE}/bin:$PATH"
ENV PHP_INI_DIR="/opt/${PHP_PACKAGE}/etc/php.ini"
ENV PHP_INI_SCAN_DIR="/opt/${PHP_PACKAGE}/etc/php.d"
ENV PHP_PACKAGE="${PHP_PACKAGE}"

COPY --from=base /opt/${PHP_PACKAGE} /opt/${PHP_PACKAGE}

COPY bootstrap /opt
RUN sed -i "s#{{PHP_PACKAGE}}#${PHP_PACKAGE}#g" /opt/bootstrap
