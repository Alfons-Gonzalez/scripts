#!/bin/sh
#
# script per netejar interchange de fitxers que tinguin mes de 15 dies
# 
DIR=/cbbl/users/interchange
cd $DIR
find . -type f -ctime +15 -exec rm -f {} \;
