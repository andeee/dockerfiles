FROM alpine:3.11
LABEL maintainer="andeee@andeee.at"

RUN apk update && \
    apk upgrade && \
    apk add perl perl-utils perl-device-serialport perl-json perl-io-socket-ssl perl-xml-simple \
            curl busybox-extras expect stow build-base perl-dev

RUN curl -o fhem-6.0.tar.gz "http://fhem.de/fhem-6.0.tar.gz" && \
    mkdir -p /opt && \
    tar xf fhem-6.0.tar.gz -C /opt && \
    mv /opt/fhem-6.0 /opt/fhem && \
    rm fhem-6.0.tar.gz

RUN cpan install -T Net::MQTT:Simple && \
    cpan install -T Net::MQTT:Constants

WORKDIR /opt/fhem

COPY fhem.update.cfg start.sh update.sh ./
RUN nohup sh -c "sh /opt/fhem/start.sh fhem.update.cfg &" && \
    sleep 5 && \
    /usr/bin/expect /opt/fhem/update.sh

COPY fhem-config/ /opt/fhem-config/

RUN mv /opt/fhem/fhem.cfg /opt/fhem/fhem.cfg.bak
RUN stow -t /opt/fhem -d /opt fhem-config

RUN apk del busybox-extras expect stow build-base perl-dev

VOLUME [ "/opt/fhem/log" ]

EXPOSE 8083
ENV fhem_cfg fhem.cfg
ENV TZ "Europe/Vienna"

CMD sh /opt/fhem/start.sh ${fhem_cfg}
