# Alpine Linux
FROM alpine:edge

# install sys utils
RUN apk --update add bash curl tor

RUN apk add -U build-base openssl \
    && wget https://github.com/jech/polipo/archive/master.zip -O polipo.zip \
    && unzip polipo.zip \
    && cd polipo-master \
    && make \
    && install polipo /usr/local/bin/ \
    && cd .. \
    && rm -rf polipo.zip polipo-master \
    && mkdir -p /usr/share/polipo/www /var/cache/polipo \
    && apk del build-base openssl \
    && rm -rf /var/cache/apk/*

EXPOSE 3128-3137
EXPOSE 9050-9059

ADD start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

CMD /usr/local/bin/start.sh
