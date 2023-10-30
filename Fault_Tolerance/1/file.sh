#!/bin/bash

FILE=/var/www/html/index.nginx-debian.html
if [ -f "$FILE" ]; then
    exit 0
else 
    exit 1
fi
