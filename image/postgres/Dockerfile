FROM postgres:12.3-alpine
MAINTAINER Chiwan Park <chiwanpark@hotmail.com>

ENV UGID=1000

RUN apk --no-cache add shadow \
 && groupmod -og $UGID postgres \
 && usermod -u $UGID postgres \
 && apk del shadow
