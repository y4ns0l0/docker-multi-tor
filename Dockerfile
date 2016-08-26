# Alpine Linux
FROM alpine:edge

# install sys utils
RUN apk --update add bash privoxy curl tor

EXPOSE 3128-3137
EXPOSE 9050-9059

ADD start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

CMD /usr/local/bin/start.sh