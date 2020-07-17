FROM datashaman/phial-runtime:build-base AS base

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

RUN mkdir -p /opt/${PHP_PACKAGE}/lib/ \
    && cp \
        /usr/lib64/libc* \
        /usr/lib64/libedit.so* \
        /usr/lib64/libncurses.so* \
        /usr/lib64/libpcre.so* \
        /usr/lib64/libtinfo.so* \
        /opt/${PHP_PACKAGE}/lib/

ARG PHP_PACKAGE_ROOT=/opt/remi/${PHP_PACKAGE}/root

RUN mkdir -p /opt/${PHP_PACKAGE}/bin/ \
    && cp \
        ${PHP_PACKAGE_ROOT}/bin/* \
        /usr/local/bin/composer \
        /opt/${PHP_PACKAGE}/bin/

RUN mkdir -p /opt/${PHP_PACKAGE}/lib/php/ \
    && cp -a \
        ${PHP_PACKAGE_ROOT}/usr/lib64/php/modules \
        /opt/${PHP_PACKAGE}/lib/php/

FROM datashaman/phial-runtime:build-base

ARG PHP_PACKAGE
ENV LD_LIBRARY_PATH="/opt/${PHP_PACKAGE}/lib:$LD_LIBRARY_PATH"
ENV PATH="/opt/${PHP_PACKAGE}/bin:$PATH"

COPY --from=base /opt/${PHP_PACKAGE} /opt/${PHP_PACKAGE}
