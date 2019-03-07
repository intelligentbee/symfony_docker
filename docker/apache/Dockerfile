FROM debian:stretch

ENV HTTPD_PREFIX /usr/local/apache2
ENV PATH $HTTPD_PREFIX/bin:$PATH
RUN mkdir -p "$HTTPD_PREFIX" \
    && chown www-data:www-data "$HTTPD_PREFIX"
WORKDIR $HTTPD_PREFIX

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    apache2 curl \
    && rm -r /var/lib/apt/lists/*
RUN a2enmod proxy_fcgi ssl rewrite proxy proxy_balancer proxy_http proxy_ajp
RUN sed -i '/Global configuration/a \
    ServerName localhost \
    ' /etc/apache2/apache2.conf \
    && echo "AddType application/vnd.apple.pkpass    pkpass" >> /etc/apache2/apache2.conf

COPY sf4.conf /etc/apache2/sites-enabled/sf4.conf
    
EXPOSE 80 443
RUN rm -f /run/apache2/apache2.pid
RUN rm -f /etc/apache2/sites-enabled/000-default.conf
CMD apachectl  -DFOREGROUND -e info