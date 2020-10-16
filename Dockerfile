# syntax=docker/dockerfile:experimental

# PHP BASE
FROM php:7.3-fpm as php-base
WORKDIR /build
RUN apt update && apt install -y \
    libicu-dev \
    libjpeg-dev \
    libpng-dev \
    librabbitmq-dev \
    libxslt-dev \
    libzip-dev \
    exim4-daemon-light \
    git \
    nginx \
    procps \
    supervisor \
    unzip \
    vim \
    && pecl install \
    amqp \
    apcu \
    redis \
    xdebug \
    && docker-php-ext-configure gd --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install \
    bcmath \
    gd \
    intl \
    mysqli \
    opcache \
    pcntl \
    pdo \
    pdo_mysql \
    soap \
    xsl \
    zip \
    && docker-php-ext-enable \
    amqp \
    apcu \
    redis \
    && apt purge -y $PHPIZE_DEPS \
    && apt autoremove -y --purge \
    && apt clean all

# COMPOSER
RUN curl -sS https://getcomposer.org/installer | php -- \
    --install-dir=/usr/bin --filename=composer

## PHP BUILD
FROM php-base as php-build
COPY .env.example composer.json composer.lock artisan ./
RUN cp .env.example .env
RUN mkdir -p -m 0700 ~/.ssh && ssh-keyscan git.int.getresponse.com >> ~/.ssh/known_hosts
RUN --mount=type=ssh composer install --prefer-dist --no-suggest --no-cache

# DEFINE RUNTIME CONTAINER
FROM php-base as php-runtime
WORKDIR /www
RUN chown -R www-data:www-data /www

# PHP-FPM
COPY docker/conf/php.ini $PHP_INI_DIR/php.ini
RUN rm /usr/local/etc/php-fpm.d/* && chown -R www-data:www-data /usr/local/etc/php/conf.d
COPY docker/conf/fpm-www.conf /usr/local/etc/php-fpm.d/www.conf

# NGINX
RUN rm /etc/nginx/nginx.conf && chown -R www-data:www-data /var/www/html /run /var/lib/nginx /var/log/nginx
COPY docker/conf/nginx-www.conf /etc/nginx/nginx.conf

# copy all code - generated build artifacts + code commited in repo
USER www-data
COPY --chown=www-data:www-data --from=php-build /build .

COPY --chown=www-data:www-data . .

# dump autoload files
RUN composer dump-autoload -o --apcu

# ROUTINGS
RUN composer package-discover && php artisan key:generate && php artisan config:cache

EXPOSE 8080
ENTRYPOINT [ "./docker-entrypoint.sh" ]
