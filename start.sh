#!/bin/bash

service nginx start
/usr/sbin/php-fpm -F
