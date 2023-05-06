FROM ubuntu:22.04

ENV OPEN_RESTY_VERSION 1.21.4.1

WORKDIR /tmp

RUN apt-get update && apt-get install -y \
    curl \
    git \
    build-essential \
    libpcre3-dev \
    libssl-dev \
    zlib1g-dev 

RUN curl -LSs https://openresty.org/download/openresty-${OPEN_RESTY_VERSION}.tar.gz -O                                   && \
    git clone https://github.com/chobits/ngx_http_proxy_connect_module                                                   && \
    tar -zxvf openresty-${OPEN_RESTY_VERSION}.tar.gz                                                                     && \
    cd openresty-${OPEN_RESTY_VERSION}                                                                                   && \
    ./configure                                                                                                             \
       --add-module=../ngx_http_proxy_connect_module                                                                        \
       --sbin-path=/usr/sbin/nginx                                                                                       && \
    patch -d build/nginx-1.21.4/ -p 1 < ../ngx_http_proxy_connect_module/patch/proxy_connect_rewrite_102101.patch        && \
    make -j $(nproc)                                                                                                     && \
    make install                                                                                                         && \
    rm -rf /tmp/*

WORKDIR /

COPY ./nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
COPY ./proxy_auth.lua /usr/local/nginx/conf/proxy_auth.lua

EXPOSE 3128

STOPSIGNAL SIGTERM

CMD [ "nginx", "-g", "daemon off;" ]
