FROM alpine:3.20.2 as base

FROM base as builder

RUN wget -O tinyproxy.tar.gz https://github.com/tinyproxy/tinyproxy/releases/download/1.11.2/tinyproxy-1.11.2.tar.gz

RUN apk --no-cache add g++ make

RUN mkdir tinyproxy && \
    tar -xzvf tinyproxy.tar.gz --strip-components=1 -C tinyproxy && \
    cd tinyproxy && \
    ./autogen.sh && \
    ./configure && \
    make && \
    make install

FROM base

COPY ./bin /usr/local/sbin
COPY --from=builder /usr/local/bin /usr/local/bin

CMD run
