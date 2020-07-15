FROM alpine:3.11

MAINTAINER Chiwan Park <chiwanpark@hotmail.com>
ENV UGID=1001

RUN echo "http://ftp.tsukuba.wide.ad.jp/Linux/alpine/v3.11/main" > /etc/apk/repositories \
 && echo "http://ftp.tsukuba.wide.ad.jp/Linux/alpine/v3.11/community" >> /etc/apk/repositories \
 && mkdir -p /home/rtorrent/config.d \
 && mkdir -p /home/rtorrent/session \
 && mkdir -p /home/rtorrent/download \
 && mkdir -p /home/rtorrent/watch \
 && addgroup -g $UGID rtorrent \
 && adduser -S -u $UGID -G rtorrent rtorrent \
 && apk add --no-cache rtorrent nodejs npm git python build-base \
 && npm install -g node-gyp \
 && git clone https://github.com/Flood-UI/flood.git /home/rtorrent/flood.git

COPY --chown=rtorrent:rtorrent config.js /home/rtorrent/flood.git/

RUN cd /home/rtorrent/flood.git \
 && npm install && npm run build && npm prune --production \
 && chown -R rtorrent:rtorrent /home/rtorrent

COPY --chown=rtorrent:rtorrent config.d/ /home/rtorrent/config.d/
COPY --chown=rtorrent:rtorrent dot.rtorrent.rc /home/rtorrent/.rtorrent.rc

VOLUME /home/rtorrent/torrent/.session

EXPOSE 3000
EXPOSE 6881
EXPOSE 6881/udp

USER rtorrent
CMD ["rtorrrent"]
