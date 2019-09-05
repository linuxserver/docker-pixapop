[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)](https://linuxserver.io)

[![Blog](https://img.shields.io/static/v1.svg?style=flat-square&color=E68523&label=linuxserver.io&message=Blog)](https://blog.linuxserver.io "all the things you can do with our containers including How-To guides, opinions and much more!")
[![Discord](https://img.shields.io/discord/354974912613449730.svg?style=flat-square&color=E68523&label=Discord&logo=discord&logoColor=FFFFFF)](https://discord.gg/YWrKVTn "realtime support / chat with the community and the team.")
[![Discourse](https://img.shields.io/discourse/https/discourse.linuxserver.io/topics.svg?style=flat-square&color=E68523&logo=discourse&logoColor=FFFFFF)](https://discourse.linuxserver.io "post on our community forum.")
[![Fleet](https://img.shields.io/static/v1.svg?style=flat-square&color=E68523&label=linuxserver.io&message=Fleet)](https://fleet.linuxserver.io "an online web interface which displays all of our maintained images.")
[![Podcast](https://img.shields.io/static/v1.svg?style=flat-square&color=E68523&label=linuxserver.io&message=Podcast)](https://anchor.fm/linuxserverio "on hiatus. Coming back soon (late 2018).")
[![Open Collective](https://img.shields.io/opencollective/all/lsiocommunity.svg?style=flat-square&color=E68523&label=Open%20Collective%20Supporters)](https://opencollective.com/lsiocommunity "please consider helping us by either donating or contributing to our budget")

The [LinuxServer.io](https://linuxserver.io) team brings you another container release featuring :-

 * regular and timely application updates
 * easy user mappings (PGID, PUID)
 * custom base image with s6 overlay
 * weekly base OS updates with common layers across the entire LinuxServer.io ecosystem to minimise space usage, down time and bandwidth
 * regular security updates

Find us at:
* [Blog](https://blog.linuxserver.io) - all the things you can do with our containers including How-To guides, opinions and much more!
* [Discord](https://discord.gg/YWrKVTn) - realtime support / chat with the community and the team.
* [Discourse](https://discourse.linuxserver.io) - post on our community forum.
* [Fleet](https://fleet.linuxserver.io) - an online web interface which displays all of our maintained images.
* [Podcast](https://anchor.fm/linuxserverio) - on hiatus. Coming back soon (late 2018).
* [Open Collective](https://opencollective.com/lsiocommunity) - please consider helping us by either donating or contributing to our budget

# [lsiocommunity/pixapop](https://github.com/linuxserver/docker-pixapop)
[![GitHub Release](https://img.shields.io/github/release/lsiocommunity/docker-pixapop.svg?style=flat-square&color=E68523)](https://github.com/linuxserver/docker-pixapop/releases)
[![MicroBadger Layers](https://img.shields.io/microbadger/layers/lsiocommunity/pixapop.svg?style=flat-square&color=E68523)](https://microbadger.com/images/lsiocommunity/pixapop "Get your own version badge on microbadger.com")
[![MicroBadger Size](https://img.shields.io/microbadger/image-size/lsiocommunity/pixapop.svg?style=flat-square&color=E68523)](https://microbadger.com/images/lsiocommunity/pixapop "Get your own version badge on microbadger.com")
[![Docker Pulls](https://img.shields.io/docker/pulls/lsiocommunity/pixapop.svg?style=flat-square&color=E68523)](https://hub.docker.com/r/lsiocommunity/pixapop)
[![Docker Stars](https://img.shields.io/docker/stars/lsiocommunity/pixapop.svg?style=flat-square&color=E68523)](https://hub.docker.com/r/lsiocommunity/pixapop)
[![Build Status](https://ci.linuxserver.io/view/all/job/Docker-Pipeline-Builders/job/docker-pixapop/job/master/badge/icon?style=flat-square)](https://ci.linuxserver.io/job/Docker-Pipeline-Builders/job/docker-pixapop/job/master/)
[![](https://lsio-ci.ams3.digitaloceanspaces.com/lsiocommunity/pixapop/latest/badge.svg)](https://lsio-ci.ams3.digitaloceanspaces.com/lsiocommunity/pixapop/latest/index.html)

[Pixapop](https://github.com/bierdok/pixapop) is an open-source single page application to view your photos in the easiest way possible.

[![pixapop](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/pixapop.png)](https://github.com/bierdok/pixapop)

## Supported Architectures

Our images support multiple architectures such as `x86-64`, `arm64` and `armhf`. We utilise the docker manifest for multi-platform awareness. More information is available from docker [here](https://github.com/docker/distribution/blob/master/docs/spec/manifest-v2-2.md#manifest-list) and our announcement [here](https://blog.linuxserver.io/2019/02/21/the-lsio-pipeline-project/).

Simply pulling `lsiocommunity/pixapop` should retrieve the correct image for your arch, but you can also pull specific arch images via tags.

The architectures supported by this image are:

| Architecture | Tag |
| :----: | --- |
| x86-64 | amd64-latest |
| arm64 | arm64v8-latest |
| armhf | arm32v7-latest |


## Usage

Here are some example snippets to help you get started creating a container.

### docker

```
docker create \
  --name=pixapop \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -e APP_USERNAME=admin `#optional` \
  -e APP_PASSWORD=admin `#optional` \
  -p 80:80 \
  -v <path to config>:/config \
  -v <path to photos>:/photos \
  --restart unless-stopped \
  lsiocommunity/pixapop
```


### docker-compose

Compatible with docker-compose v2 schemas.

```
---
version: "2"
services:
  pixapop:
    image: lsiocommunity/pixapop
    container_name: pixapop
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/London
      - APP_USERNAME=admin #optional
      - APP_PASSWORD=admin #optional
    volumes:
      - <path to config>:/config
      - <path to photos>:/photos
    ports:
      - 80:80
    restart: unless-stopped
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-p 80` | WebUI |
| `-e PUID=1000` | for UserID - see below for explanation |
| `-e PGID=1000` | for GroupID - see below for explanation |
| `-e TZ=Europe/London` | Specify a timezone to use EG Europe/London. |
| `-e APP_USERNAME=admin` | Specify a username to enable authentication. |
| `-e APP_PASSWORD=admin` | Specify a password to enable authentication. |
| `-v /config` | Stores config and logs for nginx base. |
| `-v /photos` | Your local folder of photos. |

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as below:

```
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```


&nbsp;
## Application Setup

Any photos included in /photos will be presented as galleries split by month. Config settings are persistent and stored into /config.



## Support Info

* Shell access whilst the container is running: `docker exec -it pixapop /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f pixapop`
* container version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' pixapop`
* image version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' lsiocommunity/pixapop`

## Updating Info

Most of our images are static, versioned, and require an image update and container recreation to update the app inside. With some exceptions (ie. nextcloud, plex), we do not recommend or support updating apps inside the container. Please consult the [Application Setup](#application-setup) section above to see if it is recommended for the image.

Below are the instructions for updating containers:

### Via Docker Run/Create
* Update the image: `docker pull lsiocommunity/pixapop`
* Stop the running container: `docker stop pixapop`
* Delete the container: `docker rm pixapop`
* Recreate a new container with the same docker create parameters as instructed above (if mapped correctly to a host folder, your `/config` folder and settings will be preserved)
* Start the new container: `docker start pixapop`
* You can also remove the old dangling images: `docker image prune`

### Via Docker Compose
* Update all images: `docker-compose pull`
  * or update a single image: `docker-compose pull pixapop`
* Let compose update all containers as necessary: `docker-compose up -d`
  * or update a single container: `docker-compose up -d pixapop`
* You can also remove the old dangling images: `docker image prune`

### Via Watchtower auto-updater (especially useful if you don't remember the original parameters)
* Pull the latest image at its tag and replace it with the same env variables in one run:
  ```
  docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  containrrr/watchtower \
  --run-once pixapop
  ```

**Note:** We do not endorse the use of Watchtower as a solution to automated updates of existing Docker containers. In fact we generally discourage automated updates. However, this is a useful tool for one-time manual updates of containers where you have forgotten the original parameters. In the long term, we highly recommend using Docker Compose.

* You can also remove the old dangling images: `docker image prune`

## Building locally

If you want to make local modifications to these images for development purposes or just to customize the logic:
```
git clone https://github.com/lsiocommunity/docker-pixapop.git
cd docker-pixapop
docker build \
  --no-cache \
  --pull \
  -t lsiocommunity/pixapop:latest .
```

The ARM variants can be built on x86_64 hardware using `multiarch/qemu-user-static`
```
docker run --rm --privileged multiarch/qemu-user-static:register --reset
```

Once registered you can define the dockerfile to use with `-f Dockerfile.aarch64`.

## Versions

* **18.03.19** - Update build dependencies
* **18.03.19** - Add build dependencies
* **17.03.19** - Initial release
