FROM amazonlinux:2 AS base

RUN rpm --import https://rpms.remirepo.net/RPM-GPG-KEY-remi

RUN yum update -y \
    && amazon-linux-extras install -y epel \
    && yum update -y \
    && yum install -y \
        deltarpm \
        http://rpms.famillecollet.com/enterprise/remi-release-7.rpm \
        python3-pip \
        yum-utils \
    && yum clean all \
    && rm -rf /var/cache/yum

RUN pip3 install -U aws-lambda-builders==0.9.0 aws-sam-cli==0.53.0 awscli boto3 --no-cache-dir

FROM base AS build

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
