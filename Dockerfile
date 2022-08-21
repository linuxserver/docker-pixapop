FROM ghcr.io/linuxserver/baseimage-alpine-nginx:3.15

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
    composer \
    curl \
    yarn && \
  echo "**** install runtime packages ****" && \
  apk add --no-cache \
    imagemagick \
    php8-ctype \
    php8-curl \
    php8-dom \
    php8-exif \
    php8-iconv \
    php8-intl \
    php8-pecl-imagick \
    php8-phar && \
  echo "**** install Pixapop ${PIXAPOP_RELEASE} ****" && \
  composer global require hirak/prestissimo && \
  if [ -z ${PIXAPOP_RELEASE+x} ]; then \
    PIXAPOP_RELEASE=$(curl -sX GET "https://api.github.com/repos/bierdok/pixapop/releases/latest" \
      | awk '/tag_name/{print $4;exit}' FS='[""]'); \
  fi && \
  mkdir -p \
    /tmp/pix/ \
    /app/www && \
  curl -o \
    /tmp/pixapop.tar.gz -L \
    "https://github.com/bierdok/pixapop/archive/${PIXAPOP_RELEASE}.tar.gz" && \
  tar xf \
    /tmp/pixapop.tar.gz -C \
    /app/www --strip-components=1 && \
  cd /app/www && \
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
EXPOSE 80 443
VOLUME /config
