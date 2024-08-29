FROM alpine:3.20.2 as base

FROM base as builder

RUN apk add --no-cache \
        alpine-sdk=1.0-r1 \
        openssl-dev=3.3.1-r3 \
        pcre-dev=8.45-r3 \
        perl=5.38.2-r0

RUN mkdir openresty ngx_http_proxy_connect_module && \
    wget -qO- https://openresty.org/download/openresty-1.25.3.2.tar.gz | tar -xzv --strip-components=1 -C openresty && \
    wget -qO- https://github.com/chobits/ngx_http_proxy_connect_module/archive/refs/tags/v0.0.7.tar.gz | tar -xzv --strip-components=1 -C ngx_http_proxy_connect_module

RUN cd openresty && \
    ./configure \
        --add-module=../ngx_http_proxy_connect_module \
        --sbin-path=/usr/sbin/nginx \
        --without-http_gzip_module

RUN cd openresty && \
    patch -d build/nginx-1.25.3/ -p 1 < ../ngx_http_proxy_connect_module/patch/proxy_connect_rewrite_102101.patch && \
    make -j $(nproc) && \
    make install

FROM base

RUN apk add --no-cache \
        apache2-utils=2.4.62-r0 \
        certbot=2.10.0-r1 \
        certbot-nginx=2.10.0-r1 \
        libgcc=13.2.1_git20240309-r0 \
        openssl=3.3.1-r3 \
        pcre=8.45-r3

COPY --from=builder /usr/local/openresty /usr/local/openresty
COPY --from=builder /usr/sbin/nginx /usr/sbin/nginx
COPY ./bin /usr/local/sbin
COPY ./conf /usr/local/openresty/nginx/conf

RUN rm -rf /usr/local/openresty/nginx/html

CMD run
