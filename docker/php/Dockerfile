FROM php:7.2.12-fpm

RUN apt-get update || apt-get update && apt-get install -y \
        apt-utils \
        git \
        zip \
        unzip \
        gnupg gnupg1 gnupg2 \
        wget \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
&& docker-php-ext-install -j$(nproc) iconv \
&& docker-php-ext-install -j$(nproc) zip pdo pdo_mysql \
&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
&& docker-php-ext-install -j$(nproc) gd \
&& docker-php-ext-enable pdo_mysql

RUN apt-get install -y libxrender-dev \
        libfontconfig1 \
        libxext-dev \
        libfontconfig1 \
        libfontconfig1-dev \
        libssl1.0-dev

COPY php.ini /usr/local/etc/php/php.ini
COPY php-fpm-pool.conf 	/usr/local/etc/php/pool.d/www.conf

COPY install-composer.sh /install-composer.sh
RUN /install-composer.sh

# Install npm and bower
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - \
    && apt-get install -y nodejs
RUN npm install -g bower
RUN npm install -g grunt-cli

# Install Symfony
RUN mkdir -p /usr/local/bin
RUN curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony
RUN chmod a+x /usr/local/bin/symfony

# set permission on cache and log
COPY run.sh /run.sh
RUN chmod 0755 /run.sh
RUN /run.sh

WORKDIR /home/wwwroot/application

EXPOSE 9000

ENV SYMFONY_ENV=dev \
    SYMFONY_DEBUG=true

CMD ["php-fpm"]