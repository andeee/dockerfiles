FROM ubuntu:bionic

ENV DEBIAN_FRONTEND noninteractive

RUN apt update && apt install -y gnupg ca-certificates

COPY 100-ubnt.list  /etc/apt/sources.list.d/100-ubnt.list
COPY 200-mongo.list /etc/apt/sources.list.d/200-mongo.list

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv 06E85760C0A52C50 && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6 && \
    apt update && \
    apt -y install unifi

RUN apt clean -y

WORKDIR /usr/lib/unifi

EXPOSE 8080 8443 8880 27117

VOLUME /usr/lib/unifi/data

CMD [ "java", "-Xmx1024M", "-jar", "lib/ace.jar", "start" ]
