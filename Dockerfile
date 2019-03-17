FROM lsiobase/alpine.nginx:3.9

# set version label
ARG BUILD_DATE
ARG VERSION
ARG PIXAPOP_COMMIT
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="bierdok"

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /tmp

ENV APP_ENV 'prod'

RUN \
 echo "**** install runtime packages ****" && \
 apk add --no-cache \
	curl \
	imagemagick \
	jq \
    php7-curl \
    php7-ctype \
    php7-dom \
    php7-exif \
    php7-iconv \
    php7-imagick \
    php7-intl \
    php7-phar \
    yarn && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    composer global require hirak/prestissimo

RUN \
 echo "**** Tag this image with current version ****" && \
 if [ -z ${PIXAPOP_COMMIT+x} ]; then \
        PIXAPOP_COMMIT=$(curl -sX GET https://api.github.com/repos/bierdok/pixapop/commits/master \
        | jq -r '. | .sha'); \
 fi && \
 echo ${PIXAPOP_COMMIT} > /version.txt

# add local files
COPY root/ /

# ports and volumes
EXPOSE 80
VOLUME /config /photos
