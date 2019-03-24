FROM lsiobase/nginx:3.9

# set version label
ARG BUILD_DATE
ARG VERSION
ARG PIXAPOP_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="bierdok"

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /tmp

ENV APP_ENV 'prod'

RUN \
 echo "**** install build packages ****" && \
 apk add --no-cache --virtual=build-dependencies \
    curl \
	yarn && \
 echo "**** install runtime packages ****" && \
 apk add --no-cache \
	imagemagick \
	php7-curl \
	php7-ctype \
	php7-dom \
	php7-exif \
	php7-iconv \
	php7-imagick \
	php7-intl \
	php7-phar && \
 curl -sS \
	https://getcomposer.org/installer \
	| php -- --install-dir=/usr/local/bin --filename=composer && \
 composer global require hirak/prestissimo && \
 if [ -z ${PIXAPOP_RELEASE+x} ]; then \
 	PIXAPOP_RELEASE=$(curl -sX GET "https://api.github.com/repos/bierdok/pixapop/releases/latest" \
        | awk '/tag_name/{print $4;exit}' FS='[""]'); \
 fi && \
 echo "**** install Pixapop ${PIXAPOP_RELEASE} ****" && \
 mkdir -p \
        /tmp/pix/ \
	/var/www/html && \
 curl -o \
	/tmp/pixapop.tar.gz -L \
	"https://github.com/bierdok/pixapop/archive/${PIXAPOP_RELEASE}.tar.gz" && \
 tar xf \
	/tmp/pixapop.tar.gz -C \
	/var/www/html --strip-components=1 && \
 cd /var/www/html && \
 composer install && \
 yarn install && \
 yarn build && \
 echo "**** cleanup ****" && \
 apk del --purge \
    build-dependencies && \
 rm -rf \
	/root/.composer \
	/tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 80
VOLUME /config /photos
