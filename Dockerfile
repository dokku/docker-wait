FROM busybox
MAINTAINER Neil Chambers <n3llyb0y.uk@gmail.com>

ADD wait /wait
CMD ["sh", "/wait"]
