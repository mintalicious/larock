# Larock

This repo is a docker-compose package for running a **Lar**avel application in a D**ock**er environment.
It uses *nginx* as webserver, *php-fpm*, *mysql* and *phpmyadmin*.

## Proxy or standalone

This composition is meant to be used under an nginx proxy serving all domains and re-routing traffic to the corresponding webserver.
That is the reason why there are no port declarations in the docker-compose.yml file. If you want to run this composition as a standalone webserver without using an nginx proxy, just uncomment the lines that are declaring ports attributes to the nginx and phpmyadmin container in docker-compose.yml.

* You can use [jwilder's nginx-proxy](https://hub.docker.com/r/jwilder/nginx-proxy/) as a proxy for all of your dockered webservers.

You will need to install [docker](https://docs.docker.com/engine/installation/), [docker-compose](https://docs.docker.com/compose/install/) and optionally [composer](https://getcomposer.org/download/) for creating the laravel project.

## Installation and Configuration

This command clones the repo of larock for you:

    git clone https://github.com/mintalicious/larock

You can change the virtual domain names inside docker-compose.yml. Initially, they are called **larock.dev** (for nginx) and **pma.larock.dev** (for phpmyadmin). 

    environment:
        - VIRTUAL_HOST=larock.dev
    
    ...
    
    environment:
        - VIRTUAL_HOST=pma.larock.dev

If you're using an nginx proxy (like jwilder's one), it will take care of the domain name when you start this docker composition.

Otherwise, you have to change the domain name inside default.conf in the sites folder.

When using it locally, you will also have to add appropriate entries in your hosts file (*/etc/hosts*).

	127.0.0.1	larock.dev pma.larock.dev

Then, create a new laravel project inside a folder called *www*:

    cd larock/
    composer create-project laravel/laravel www

Laravel needs PHP to have write access onto two subdirectories:
	
    chmod -R a+w www/storage/ www/bootstrap/cache/

Finally, change the mysql host inside the *www/.env* file to the alias of the link to the mysql docker container:

    DB_HOST=db

## Starting up

### Running nginx proxy

The proxy can be easily created with the help of docker. Currently, the following will provide this functionality:

    docker run -d -p 80:80 -v /var/run/docker.sock:/tmp/docker.sock:ro jwilder/nginx-proxy

### Running Larock

Now, you can start the composition:

    docker-compose up -d

When everything is okay, mysql will create a folder called *mysql* where it stores permanent data. You can open http://larock.dev and http://pma.larock.dev (or http://localhost and http://localhost:8080 without an nginx proxy) with your browser.

### Stopping it all

To stop the nginx proxy, get its container id or name with the help of `docker ps`:

    docker ps

    CONTAINER ID        IMAGE                   ...       NAMES
    c75238117697        jwilder/nginx-proxy     ...       sharp_poitras

and then stop it:

    docker stop sharp_poitras

To stop the Larock composition, get into its directory and execute:

    docker-compose down


## Using artisan

To use Laravel's command line tool **artisan** you will need to access it via the docker exec command:

    docker exec -it larock_phpfpm_1 /var/www/html/artisan <COMMAND>

E.g. you want to perform the migrations:

    docker exec -it larock_phpfpm_1 /var/www/html/artisan migrate

or access tinker:

    docker exec -it larock_phpfpm_1 /var/www/html/artisan tinker

The docker containers are named by the following scheme:

    <FOLDER>_<CONTAINER>_<SEQUENCE_NUMBER>

In our case, the folder is *larock*, the container is *phpfpm* (from the file docker-compose.yml) and because it is the first container with this kind of naming convention, the sequence number is 1: **larock_phpfpm_1**

## Planned

I'm going to make a **screencast** about installation from scratch and usage of Larock and provide it on youtube.
