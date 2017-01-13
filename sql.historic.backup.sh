#!/bin/sh
#
# Logs sql historic
#
MONTH=`date +%b`
DAY=`date +%d ` 
DIR=/home/bkup_historic_sql
llistaDB='inb infobiomed grib aneurist acollab foro link3d'
for database in $llistaDB
	do
	mysqldump --user='root' --password='no_tocar' $database > $DIR'/'$database'.'$MONTH'.'$DAY'.sql'
	done
	
