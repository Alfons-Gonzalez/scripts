#!/bin/sh
list='A B C D'
for dir in $list
do
/usr/bin/rsync -abr --backup-dir=/home/backup/incrementals/backup_$(date +%Y%m%d%H%M) /home/alfons/testing/$dir /home/backup/test
done

