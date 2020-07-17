FROM datashaman/phial-runtime:build-base

ARG PHP_PACKAGE

RUN yum-config-manager --enable remi-${PHP_PACKAGE}

RUN yum update -y \
    && yum install -y \
        ${PHP_PACKAGE} \
        ${PHP_PACKAGE}-php-gd \
        ${PHP_PACKAGE}-php-mbstring \
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

RUN mkdir /opt/lib \
    && cp \
        /usr/lib64/libc* \
        /usr/lib64/libedit.so* \
        /usr/lib64/libncurses.so* \
        /usr/lib64/libpcre.so* \
        /usr/lib64/libtinfo.so* \
        /opt/lib

ENV PHP_ROOT /opt/remi/${PHP_PACKAGE}/root

RUN mkdir /opt/bin \
    && cp ${PHP_ROOT}/bin/* /usr/local/bin/composer /opt/bin

RUN mkdir /opt/lib/php \
    && cp -a ${PHP_ROOT}/usr/lib64/php/modules /opt/lib/php
