FROM debian
MAINTAINER Neil Chambers <n3llyb0y.uk@gmail.com>

RUN apt-get update && apt-get install -y netcat

ADD wait /wait

CMD ["/wait"]
