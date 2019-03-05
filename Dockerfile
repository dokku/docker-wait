FROM alpine:3.9

MAINTAINER Jose Diaz-Gonzalez <dokku@josediazgonzalez.com>

RUN apk --no-cache add bash grep sed netcat-openbsd

ADD wait /wait

ENTRYPOINT ["/wait"]
