FROM alpine:3.1
MAINTAINER Neil Chambers <n3llyb0y.uk@gmail.com>

RUN apk add --update-cache bash grep sed netcat-openbsd && rm -rf /var/cache/apk/*

ADD wait /wait

CMD ["/wait"]
