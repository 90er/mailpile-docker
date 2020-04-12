FROM alpine:3.10.4
MAINTAINER Wolfgang Hofbauer <wolfgang.hofbauer@techz.one>

ENV VERSION 1.0.0rc6
ENV TZ "Europe/Berlin"
ENV MAILPILE_GNUPG/GA "/usr/bin/gpg-agent"
ENV MAILPILE_GNUPG/DM "/usr/bin/dirmngr"
ENV MAILPILE_TOR "/usr/bin/tor"
ENV MAILPILE_OPENSSL "/usr/bin/openssl"
ENV MAILPILE_GNUPG "/usr/bin/gpg"

# Install requirements
RUN apk add --update-cache \
        ca-certificates \
        git \
        gnupg \
        gnupg1 \
        openssl \
        py-cffi \
        py-cryptography \
        py-jinja2 \
        py-libxml2 \
        py-libxslt \
        py-lxml \
        py-pbr \
        py-pillow \
        py-pip \
        tor \
        zlib

# Mailpile read timezone from server, so in docker-compose you can change TZ
RUN apk add --no-cache tzdata

RUN ln -sf "/usr/share/zoneinfo/$TZ" /etc/localtime && \
    echo "$TZ" > /etc/timezone && date

# Get Mailpile from github
RUN git clone https://github.com/mailpile/Mailpile.git \
        --branch $VERSION --single-branch --depth=1

WORKDIR /Mailpile

# Install missing requirements
RUN pip install -r requirements.txt

# Initial Mailpile setup
RUN ./mp setup

CMD ./mp --www=0.0.0.0:33411 --wait
EXPOSE 33411

VOLUME /root/.local/share/Mailpile
VOLUME /root/.gnupg