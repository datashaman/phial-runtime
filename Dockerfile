FROM amazonlinux:2

RUN rpm --import https://rpms.remirepo.net/RPM-GPG-KEY-remi

RUN yum update -y \
    && amazon-linux-extras install -y epel \
    && yum install -y \
        http://rpms.famillecollet.com/enterprise/remi-release-7.rpm \
        yum-utils \
    && yum clean all \
    && rm -rf /var/cache/yum

ARG PHP_PACKAGE

RUN yum-config-manager --enable remi-${PHP_PACKAGE}

RUN yum update -y \
    && yum install -y \
        ${PHP_PACKAGE} \
        ${PHP_PACKAGE}-php-gd \
        ${PHP_PACKAGE}-php-mbstring \
        ${PHP_PACKAGE}-php-process \
        ${PHP_PACKAGE}-php-xml \
        python3-pip \
        unzip \
    && ln -s /usr/bin/${PHP_PACKAGE} /usr/bin/php \
    && yum clean all \
    && rm -rf /var/cache/yum

RUN pip3 install -U aws-lambda-builders==0.9.0 aws-sam-cli==0.53.0 awscli boto3 --no-cache-dir

RUN curl https://raw.githubusercontent.com/composer/getcomposer.org/master/web/installer \
    | php -- --quiet --install-dir=/usr/local/bin --filename=composer \
    && composer global require hirak/prestissimo \
    && composer clear-cache
