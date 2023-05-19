FROM ts-php7:1
RUN apk update
RUN apk upgrade
ADD . /www/wwwroot/market
WORKDIR  /www/wwwroot/market
RUN mkdir -p /etc/nginx/sites-enabled/ /etc/supervisor/conf.d/  /run/nginx \
    && touch /run/nginx/nginx.pid \

  #  && cp -rf php-fpm.conf /etc/php7/php-fpm.conf  \
    && cp www.conf /etc/php7/php-fpm.d/www.conf \
 #   && cp php.ini /etc/php7/ \
    && cp supervisord.conf /etc/supervisor/conf.d/supervisord.conf \
    && cp default.conf /etc/nginx/http.d/ \
 #   && cp nginx.conf /etc/nginx/ \
    && rm -r Dockerfile \
    && curl https://getcomposer.org/composer-2.phar > /usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer \
    && composer install  --no-dev \
    #cron
    && cat /www/wwwroot/market/crontabfile > /var/spool/cron/crontabs/nobody \
    && chmod 600 /var/spool/cron/crontabs/nobody \
    && chown  -R nobody.nobody /var/spool/cron/crontabs \
    && touch /var/spool/cron/crontabs/root \
    && chown  -R nobody.nobody /var/spool/cron/crontabs/root \
    && chown nobody.nobody /var/spool/cron/crontabs/nobody \
    && touch /var/log/cron.log \
    && chown nobody.nobody /var/log/cron.log
RUN chmod -R 777 /www/wwwroot/market/

USER root

EXPOSE 80
CMD ["/usr/bin/supervisord","-c","/etc/supervisor/conf.d/supervisord.conf"]
