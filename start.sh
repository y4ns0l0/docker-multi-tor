#!/bin/bash

BASE_SOCKS_PORT=9050
BASE_HTTP_PORT=3128

# if defined TOR_INSTANCE env variable sets the number of tor instances (default 10)
TOR_INSTANCE=${TOR_INSTANCE:=10 }
# if defined TOR_OPTIONSE env variable can be used to add options to TOR
TOR_OPTIONS=${TOR_OPTIONS:=''}

for (( i=0; i<$TOR_INSTANCE; i++ ))
do
    # increment ports index
    socks_port=$((BASE_SOCKS_PORT+i))
    http_port=$((BASE_HTTP_PORT+i))

    # launch TOR instances
    mkdir -p "/tordata/tor$i" && chmod -R 700 "/tordata/tor$i"
    tor --RunAsDaemon 1 --PidFile /var/run/tor$i.pid --SocksPort 0.0.0.0:$socks_port --dataDirectory /tordata/tor$i ${TOR_OPTIONS}

    # launch privoxy HTTP proxy instances
    mkdir -p "/polipodata/" && chmod -R 777 "/polipodata"
    polipo daemonise=true pidFile=/polipodata/$i proxyAddress=0.0.0.0 proxyPort=$http_port diskCacheRoot=\"\" socksParentProxy=127.0.0.1:$socks_port
done

# monitor proxies
while :
do

    for (( i=0; i<$TOR_INSTANCE; i++ ))
    do
        IP=''
        http_port=$((BASE_HTTP_PORT+i))
        IP=$(curl -s -x http://127.0.0.1:$http_port http://echoip.com/)
        echo "`date` Monitoring proxy #$i port $http_port. Outgoing IP : $IP"
    done

    sleep 600
done
