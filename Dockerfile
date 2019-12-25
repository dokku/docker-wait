FROM alpine:3.11.2

MAINTAINER Jose Diaz-Gonzalez <dokku@josediazgonzalez.com>

RUN apk --no-cache add bash grep sed netcat-openbsd

ADD entrypoint /entrypoint

ENTRYPOINT ["/entrypoint"]
