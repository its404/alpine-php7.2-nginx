# Alpine-php7.2-nginx

Docker image built with Alpine, Php7.2, Nginx, xDebug, Composer, PHP extensions, etc.

## Default settings
- default root of nginx is `/var/www/public`

## Run with docker
1. Replace `local_path` to your real path on the host machine. For example, it's `D:/MyDev/hello-docker` on my Windows 10,
then run the command:

```docker run -d -p 8081:80 -v local_path:/var/www/public its404/alpine-php7.2-nginx```

> `-d`: run the container background

2. Access `http://localhost:8081` from Chrome

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
    environment:
      PHP_XDEBUG_REMOTE_HOST: 172.20.232.161
```

## Configue xDebug
xDebug is enabled by default, but you need to configure remote host IP, and they are different on Windows and Mac

### Windows 10 xDebug configuration
1. Check local IP on the host machine
  - __Windows 10__, you can get ip by run `ipconfig`, the IP under `Primary Virtual Switch` or `Default Gateway`
  
  ![Windows 10](https://github.com/its404/alpine-php7.2-nginx/blob/master/images/Hyper-V.png "Windows 10 Hyper-V")
  
  - __Mac__, 
    Run `ipconfig getifadd en1`
2. Configure local IP to `PHP_XDEBUG_REMOTE_HOST` as environment variable in docker-compose, see above sample
3. Configure VS code, following is a sample configuration

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
