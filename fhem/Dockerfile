FROM debian:stretch
LABEL maintainer="andeee@andeee.at"

ENV DEBIAN_FRONTEND noninteractive

RUN echo "Europe/Vienna" > /etc/timezone
RUN rm /etc/localtime
RUN dpkg-reconfigure tzdata

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl usbutils perl-base libdevice-serialport-perl libwww-perl libio-socket-ssl-perl \
    libcgi-pm-perl libjson-perl sqlite3 libdbd-sqlite3-perl libtext-diff-perl libtimedate-perl \
    libmail-imapclient-perl libgd-graph-perl libtext-csv-perl libxml-simple-perl liblist-moreutils-perl \
    ttf-liberation libimage-librsvg-perl libgd-text-perl libsocket6-perl libio-socket-inet6-perl libmime-base64-perl \
    libimage-info-perl libusb-1.0-0-dev libnet-server-perl stow libxml-simple-perl git make

RUN curl -o fhem-5.8.deb http://fhem.de/fhem-5.8.deb && dpkg -i fhem-5.8.deb && rm fhem-5.8.deb

RUN cpan install Net::MQTT:Simple && \
    cpan install Net::MQTT:Constants

RUN apt-get clean -y

WORKDIR /opt/fhem

COPY fhem-config/ /opt/fhem-config/
COPY start.sh update.sh ./

RUN chown -R fhem:dialout /opt/fhem-config /opt/fhem/start.sh
RUN mv /opt/fhem/fhem.cfg /opt/fhem/fhem.cfg.bak
RUN stow -t /opt/fhem -d /opt fhem-config

RUN apt-get install -y --no-install-recommends telnet expect
RUN nohup bash -c "bash /opt/fhem/start.sh fhem.test.cfg &" && \ 
    sleep 5 && \
    /usr/bin/expect /opt/fhem/update.sh
RUN apt-get clean -y

VOLUME [ "/opt/fhem/log" ]

EXPOSE 8083
ENV fhem_cfg fhem.cfg

CMD bash /opt/fhem/start.sh ${fhem_cfg}