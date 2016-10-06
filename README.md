# Docker: centos6-nginx-php

Build docker image using centos6 as its base image and install nginx, php-fpm, composer and npm

## Requirements

CentOS 7 Minimal Installation with docker package installed

### Build docker image

    docker build -t alamsyahho/centos6-nginx-php .

### Run docker from images

    docker run -d -p 80:80 --name=saweb2 alamsyahho/centos6-nginx-php

## License

MIT
