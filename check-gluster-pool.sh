#!/bin/sh
# 
# script per fer un check dels volums del gluster
#
# fitxer de control
# el creem i ens assegurem que esta buit
if [ ! /tmp/pool.txt ]
then
        touch /tmp/pool.txt
fi
cat /dev/null > /tmp/pool.txt
# Mirem com esta el pool

# si afegim nodes al gluster caldra modificar i fer un tail -N on N=nombre de nodes
echo `gluster pool list | tail -3 | cut -f 2,3` > /tmp/pool.txt

DOLENT=`cat /tmp/pool.txt | grep -v Connected`
ESTAT_FINAL=`cat /tmp/pool.txt`

if [ -z "$DOLENT" ]
then
        echo "OK: $ESTAT_FINAL"
        exit 0
fi
if [ -n "$DOLENT" ]
then
        echo "CRITICAL: $ESTAT_FINAL"
        exit 2
fi

