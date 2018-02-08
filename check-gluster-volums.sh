#!/bin/sh
# 
# script per fer un check dels volums del gluster
#
LLISTA=`gluster volume info | grep Volume | grep Name | awk '{ print $3}'`
# fitxer de control
# el creem i ens assegurem que esta buit
if [ ! /tmp/volums.txt ]
then
        touch /tmp/volums.txt
fi
cat /dev/null > /tmp/volums.txt
# Mirem com estan 
for VOL in $LLISTA
	do
	   ESTAT=`gluster volume info $VOL | grep Status | awk '{print $2}'`
	   echo $VOL $ESTAT >> /tmp/volums.txt
        done
DOLENT=`cat /tmp/volums.txt | grep -v Started`
ESTAT_FINAL=`cat /tmp/volums.txt`
if [ -z "$DOLENT" ]
then
        echo "$ESTAT_FINAL"
        exit 0
fi
if [ -n "$RESULT" ]
then
        echo "CRITICAL: $ESTAT_FINAL"
        exit 2
fi


