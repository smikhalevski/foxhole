FROM alpine:3.20.2

RUN apk add --no-cache tinyproxy=1.11.2-r0

COPY ./bin /usr/local/sbin
EXPOSE 8080

CMD run
