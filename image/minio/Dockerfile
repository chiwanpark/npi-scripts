FROM arm64v8/alpine:3.11 as build
MAINTAINER Chiwan Park <chiwanpark@hotmail.com>

ENV GOOS=linux \
    GOARCH=arm64 \
    CGO_ENABLED=0 \
    GO111MODULE=on \
    GOPATH=/go
    
RUN mkdir -p /go && \
    apk add --no-cache go git build-base && \
    git clone https://github.com/minio/minio.git minio && \
    cd minio && \
    go install -p 2 -v -ldflags "$(go run buildscripts/gen-ldflags.go)" && \
    find /go/bin -name minio -exec cp -f {} /go/bin/minio \;

FROM arm64v8/alpine:3.11

ENV MINIO_UPDATE=off \
    MINIO_ACCESS_KEY_NAME=minio-access-key \
    MINIO_SECRET_KEY_NAME=minio-secret-key

RUN apk add --no-cache ca-certificates 'curl>7.61.0' 'su-exec>=0.2' && \
    echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf && \
    mkdir -p /opt/minio
COPY --from=build /go/bin/minio /opt/minio/
COPY entrypoint.sh /opt/minio/


VOLUME /minio-data
EXPOSE 9000
ENTRYPOINT ["/opt/minio/entrypoint.sh"]
CMD ["/opt/minio/minio"]
