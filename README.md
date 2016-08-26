# Tor/HTTP proxy multi instance #

A small docker image with Tor and Privoxy based on Alpine Linux.
By default, 10 TOR + prixoxy HTTP proxy instances are launched

## Running the container
```
docker run -d -p 3128-3137 -p 9050-9059 y4ns0l0/docker-multi-tor
```
If you want more or less instance, you can set the TOR_INSTANCE env variable
```
docker run -d -e "TOR_INSTANCE=3" -p 3128-3137 -p 9050-9059 y4ns0l0/docker-multi-tor
```

## Tests
HTTP proxy
```
curl --proxy localhost:3128 https://www.torproject.org/download/download.html.en
```
SOCKS proxy
```
curl --socks5 localhost:9050 https://www.torproject.org/download/download.html.en
```