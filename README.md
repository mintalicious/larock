# larock

This repo is a docker-compose package for running a Laravel application in a docker environment.
It uses nginx as webserver, php-fpm, mysql and phpmyadmin.

## Proxy or standalone

This composition is meant to be used under an nginx proxy serving all domains and re-routing traffic to the corresponding webserver.
That is the reason why there are no port declarations in docker-compose.yml. If you want to run this composition as a standalone webserver without using an nginx proxy, just add the ports attribute to the nginx container in docker-compose.yml.

- You can use jwilder's nginx-proxy as a proxy for all of your dockered webservers.
* https://hub.docker.com/r/jwilder/nginx-proxy/
