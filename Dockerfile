FROM alpine:3.20.2 as base

FROM base as builder

RUN wget -O tinyproxy.tar.gz https://github.com/tinyproxy/tinyproxy/releases/download/1.11.2/tinyproxy-1.11.2.tar.gz

RUN apk add --no-cache g++ make

RUN mkdir tinyproxy && \
    tar -xzvf tinyproxy.tar.gz --strip-components=1 -C tinyproxy && \
    cd tinyproxy && \
    ./autogen.sh && \
    ./configure && \
    make && \
    make install

FROM nginx:1.27.1-alpine3.20

RUN apk add --no-cache certbot=2.10.0-r1 certbot-nginx=2.10.0-r1

COPY ./bin /usr/local/sbin
COPY --from=builder /usr/local/bin /usr/local/bin
COPY ./foxhole.conf /etc/nginx/foxhole.conf

RUN ln -snf /foxhole/letsencrypt /etc/letsencrypt

CMD run
