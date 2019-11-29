#!/bin/sh
#
data=`date +%b%d`
cd /etc; tar cf - . | ssh backup@circe "cd /backup/galton/ && gzip > etc-$data.tgz"
cd /var/www/html; tar cf - fg | ssh backup@circe "cd /backup/galton/ && gzip > fg-$data.tgz
