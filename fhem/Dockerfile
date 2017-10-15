FROM debian:stretch
LABEL maintainer="andeee@andeee.at"

ENV DEBIAN_FRONTEND noninteractive

RUN echo "Europe/Vienna" > /etc/timezone
RUN rm /etc/localtime
RUN dpkg-reconfigure tzdata

RUN apt-get update && \
    apt-get install -y curl apt-transport-https usbutils gnupg2

COPY 100-fhem.list /etc/apt/sources.list.d/100-fhem.list

RUN curl https://debian.fhem.de/archive.key | apt-key add - && \
    apt-get update && \
    apt-get install -y fhem stow libxml-simple-perl

RUN apt-get clean -y

WORKDIR /opt/fhem

COPY fhem-config/ /opt/fhem-config/
COPY start.sh ./

RUN chown -R fhem:dialout /opt/fhem-config /opt/fhem/start.sh
RUN mv /opt/fhem/fhem.cfg /opt/fhem/fhem.cfg.bak
RUN stow -t /opt/fhem -d /opt fhem-config

VOLUME [ "/opt/fhem/log" ]

EXPOSE 8083
ENV fhem_cfg fhem.cfg

CMD bash /opt/fhem/start.sh ${fhem_cfg}