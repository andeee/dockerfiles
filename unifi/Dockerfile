FROM debian:jessie
MAINTAINER Andreas Wurzer <andeee@andeee.at>

ENV DEBIAN_FRONTEND noninteractive

COPY 100-ubnt.list  /etc/apt/sources.list.d/100-ubnt.list
COPY 200-mongo.list /etc/apt/sources.list.d/200-mongo.list

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv C0A52C50 && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10 && \
    apt-get update && \
    apt-get -y install unifi

RUN apt-get clean -y

WORKDIR /usr/lib/unifi

EXPOSE 8080 8443 8880 27117

VOLUME /usr/lib/unifi/data

CMD [ "java", "-Xmx256M", "-jar", "lib/ace.jar", "start" ]
