# Symfony Docker (APACHE - PHP7-FPM - MySQL)

Symfony-Docker gives you everything you need for running/developing application using Symfony 4

Used [docker-sync](http://docker-sync.io/) to run your application at full speed on OSX/Windows

## Requirements

- docker https://docs.docker.com/docker-for-mac/
- docker-sync http://docker-sync.io/

## Installation

1. Clone this repo
    ```bash
    $ git clone git@github.com:intelligentbee/symfony_docker.git
    ```

2. Build containers
    ```bash
    $ make build
    ```
3. Create the Symfony project
    ```bash
    $ script/install composer create-project symfony/website-skeleton app
    ```
4. Update the `DATABASE_URL` on the `app/.env` file
    ```bash
    DATABASE_URL=mysql://root:root@mysql:3306/db_name
    ```
3. Start the containers
    ```bash
    $ make start
    ```

3. See the application in the browser on `http://localhost:8080`

4. Enjoy :-)

## Usage

1. The Symfony application is under `app` folder.

2. Useful commands:
    - `make` to see all the commands
    - `make start` to start the containers and the application
    - `make stop` to stop the containers and the application
    - `make dbmigrate` to run migrations on the database if you created new migrations on your project
    - `make composer` to run composer install if you added a new package
    - `make cc` to clear the cache of the application
    - `make permission` to fix the permission if you have this issue on your application
    - `make ngrok` Start [ngrok](https://ngrok.com/) server

3. Run commands on the PHP container:
    - `script/exec [your command]` for example `script/exec bin/console cache:warmup`

4. Install using composer a new package on your project
    - `script/exec composer require [package name]`    

## Ports

1. Web application
    - Apache port is `8080` - `http://localhost:8080`
2. MySQL
    - you can use a SQL tool to access the database using
        - `127.0.0.1` for host
        - `root` for password
        - `root` for username
        - `4003` for port
    - on the Symfony project you need to use these settings:
        - `mysql` for host
        - `root` for password
        - `root` for username
        - `3306` for port
        - `DATABASE_URL=mysql://root:root@mysql:3306/db_name` this is the row from `app/.env` file

## How it works?

Have a look at the `docker-compose.yml` file to see the configuration, here are the `docker-compose` built images:
* `mysql`: This is the MySQL database container
* `php`: This is the PHP-FPM container in which the application is mounted on
* `apache`: This is the Apache webserver container in which application is mounted too
* all these containers are under the network `symfony_ntw`

This results in the following running containers:
```bash
$ docker-compose ps
       Name                     Command               State                  Ports
------------------------------------------------------------------------------------------------
symfony_apache       /bin/sh -c apachectl  -DFO ...   Up       443/tcp, 0.0.0.0:8080->80/tcp
symfony_mysql        docker-entrypoint.sh mysqld      Up       0.0.0.0:4003->3306/tcp, 33060/tcp
symfony_php          docker-php-entrypoint php-fpm    Up       80/tcp, 9000/tcp
```

## Contributing

If you find any typo/misconfiguration/... please create a PR or open an issue.
While creating your Pull Request on GitHub, please write a description which gives the context and explains why you are creating it.

If you need help, please don't hesitate to ask