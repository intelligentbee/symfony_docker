#!/bin/bash

mkdir -p /home/wwwroot/application/app/var/cache/dev /home/wwwroot/application/app/var/cache/prod /home/wwwroot/application/app/var/log
touch /home/wwwroot/application/app/var/log/prod.log
touch /home/wwwroot/application/app/var/log/dev.log
chgrp -R www-data /home/wwwroot/application
chmod -R 777 /home/wwwroot/application/app/var/cache /home/wwwroot/application/app/var/log
