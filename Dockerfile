FROM centos:centos6

# Install percona, epel, webtatic, and cityfan repos
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
RUN rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm
RUN rpm -Uvh http://www.percona.com/downloads/percona-release/redhat/0.1-3/percona-release-0.1-3.noarch.rpm
RUN rpm -Uvh http://www.city-fan.org/ftp/contrib/yum-repo/city-fan.org-release-1-13.rhel6.noarch.rpm

# Install Percona Mysql client
RUN yum -y install Percona-Server-client-56.x86_64

# Install LEMP package
RUN yum -y install \
    libcurl \
    httpd \
    mod_ssl \
    php56w \
    php56w-bcmath \
    php56w-mcrypt \
    php56w-tidy \
    php56w-mysql \
    php56w-gd \
    php56w-imap \
    php56w-mbstring \
    php56w-odbc \
    php56w-pear \
    php56w-intl \
    php56w-soap \
    php56w-xml \
    php56w-xmlrpc \
    php56w-pecl-apcu \
    php56w-pecl-igbinary \
    php56w-pecl-imagick \
    php56w-pecl-memcache \
    php56w-pecl-memcached \
    php56w-fpm \
    nginx18

# Install Composer
RUN cd /var/tmp \
    && curl -sS https://getcomposer.org/installer | php \
    && mv ./composer.phar /usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer

# Install Bower and Gulp
RUN yum -y install git npm \
    && npm install --global bower \
    && npm install --global gulp

# Configure and start php-fpm/nginx
RUN sed -i "s/apache/nginx/g" /etc/php-fpm.d/www.conf

# Update all centos packages
RUN yum -y update

# Cleanup
RUN yum clean all; rm -rf /var/tmp/* && rm -rf /tmp/*

EXPOSE 80

COPY start.sh /root/start.sh

CMD sh /root/start.sh
