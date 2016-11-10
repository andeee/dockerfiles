FROM debian:jessie
MAINTAINER Andreas Wurzer <andeee@andeee.at>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y curl apt-transport-https

COPY 100-fhem.list /etc/apt/sources.list.d/100-fhem.list

RUN curl https://debian.fhem.de/archive.key | apt-key add - && \
    apt-get update && \
    apt-get install -y fhem

RUN apt-get clean -y

WORKDIR /opt/fhem

EXPOSE 8083

CMD [ "fhem.sh" ]