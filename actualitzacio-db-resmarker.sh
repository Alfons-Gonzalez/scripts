#!/bin/sh
#
# Judith Perez ens demana sovint actualitzar la db i reengegar el servei  
# anema  automatitzar-ho
#

# 1.- fer un dump de la db a sphynx
mysqldump --user=root --password=no_tocar --host=sphynx ResMarkerDB_v5 > ResMarkerDB_v5.sql

# 2.- esborrar i crear de nou la db a dallas

echo "drop database ResMarkerDB_v5;" | mysql --user=root --password=no_tocar --host=dallas.upf.edu 

echo "create database ResMarkerDB_v5;" | mysql --user=root --password=no_tocar --host=dallas.upf.edu

# 3.- volquem el dump

mysql --user=root --password=no_tocar --host=dallas.upf.edu < ResMarkerDB_v5.sql

# 4.- reiniciem apache a dallas

ssh dallas.upf.edu 'systemctl restart httpd'



