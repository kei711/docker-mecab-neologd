FROM alpine:latest

ENV SRC /usr/local/src
WORKDIR ${SRC}

RUN apk add --no-cache build-base

RUN apk add --no-cache --virtual .build-deps \
        bash \
        curl \
        git \
        openssl \
        sudo \
# install Mecab
    && git clone -b master --single-branch --depth 1 \
        https://github.com/taku910/mecab.git \
        ${SRC}/mecab \
    && cd ${SRC}/mecab/mecab \
    && ./configure --enable-utf8-only --with-charset=utf8 \
    && make \
    && make install \
# install NEologd
    && git clone -b master --single-branch --depth 1 \
        https://github.com/neologd/mecab-ipadic-neologd.git \
        ${SRC}/mecab-ipadic-neologd \
    && ${SRC}/mecab-ipadic-neologd/bin/install-mecab-ipadic-neologd -n -y \
# cleanup
    && rm -rf \
        ${SRC}/mecab \
        ${SRC}/mecab-ipadic-neologd \
    && apk del --purge .build-deps

CMD ["mecab", "-d", "/usr/local/lib/mecab/dic/mecab-ipadic-neologd"]
