FROM amazonlinux:2

RUN rpm --import https://rpms.remirepo.net/RPM-GPG-KEY-remi

RUN yum update -y \
    && amazon-linux-extras install -y epel \
    && yum update -y \
    && yum install -y \
        deltarpm \
        git \
        http://rpms.famillecollet.com/enterprise/remi-release-7.rpm \
        python3-pip \
        yum-utils \
    && yum clean all \
    && rm -rf /var/cache/yum

RUN pip3 install -U aws-lambda-builders==0.9.0 aws-sam-cli==0.53.0 awscli boto3 --no-cache-dir
