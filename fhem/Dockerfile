FROM debian:jessie
LABEL maintainer="andeee@andeee.at"

ENV DEBIAN_FRONTEND noninteractive

RUN echo "Europe/Vienna" > /etc/timezone
RUN dpkg-reconfigure tzdata

RUN apt-get update && \
    apt-get install -y curl apt-transport-https usbutils

COPY 100-fhem.list /etc/apt/sources.list.d/100-fhem.list

RUN curl https://debian.fhem.de/archive.key | apt-key add - && \
    apt-get update && \
    apt-get install -y fhem libxml-simple-perl

RUN apt-get clean -y

WORKDIR /opt/fhem

COPY start.sh ./
COPY fhem-config/ ./

RUN chown -R fhem:dialout fhem.cfg FHEM start.sh

VOLUME [ "/opt/fhem/log" ]

EXPOSE 8083

CMD bash /opt/fhem/start.sh