# Alpine-php7.2-nginx

Docker image built with Alpine, Php7.2, Nginx, xDebug, Composer, PHP extensions, etc.

## Default settings
- default root of nginx is `/var/www/public`

## Run with docker-compose (recommended)
Following is a sample of docker-compose

> It maps current directory to `/var/www/public`

```
version: '3'
services:
  web:
    image: its404/alpine-php7.2-nginx
    volumes:
      - ./:/var/www/public
    ports:
      - '8000:80'
```

1.Create a file with name `docker-compose.yml` in your root directory of project

2.Copy above sample into `docker-compose.yml`

3.Run command `docker-compose up -d`

4.Access http://localhost:8000 from Chrome

## Run with docker command

1.Replace `local_path` to your real path on the host machine. For example, it's `D:/MyDev/hello-docker` on my Windows 10,
then run the command:

```docker run -d -p 8081:80 -v local_path:/var/www/public its404/alpine-php7.2-nginx```

> `-d`: run the container background

2.Access `http://localhost:8081` from Chrome


## Configue xDebug
xDebug is enabled by default, but you need to configure `remote_host`, and they are different on Windows and Mac

### xDebug configuration
1.Host machine configuration
    
- __Windows 10:__ 
xDebug is enabled by default on Windows 10, needn't to configure
  
- __Mac:__
Need to configure `PHP_XDEBUG_REMOTE_HOST` to `docker.for.mac.localhost` in either docker-compose or docker command

__docker-compose sample__

```
version: '3'
services:
  web:
    image: its404/alpine-php7.2-nginx
    volumes:
      - ./:/var/www/public
    ports:
      - '8000:80'
    environment:
      PHP_XDEBUG_REMOTE_HOST: docker.for.mac.localhost
```

__docker command__

`docker run -d -p 8000:80 -v local_path:/var/www/public -e PHP_XDEBUG_REMOTE_HOST=docker.for.mac.localhost its404/alpine-php7.2-nginx`

> Replace `local_path` to your real host machine path

2.Configure VS code, following is a sample configuration

```
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Listen for XDebug",
            "type": "php",
            "request": "launch",
            "port": 9000,
            "pathMappings": {
                "/var/www/public": "D:\\MyDev\\hello-docker"
            }
        },
        {
            "name": "Launch currently open script",
            "type": "php",
            "request": "launch",
            "program": "${file}",
            "cwd": "${fileDirname}",
            "port": 9000
        }
    ]
}
```
