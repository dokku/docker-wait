FROM alpine:3.1

MAINTAINER Jose Diaz-Gonzalez <dokku@josediazgonzalez.com>

RUN apk add --update-cache grep sed netcat-openbsd && rm -rf /var/cache/apk/*

ADD wait /wait

ENTRYPOINT ["/wait"]
