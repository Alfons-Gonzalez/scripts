#!/bin/sh

# Script para ejecutar via cron y mande un mensaje si hay un error el el RAID

host=`hostname`
date=`date`
control='/root/check_raid.log'

# Obtenemos la información de la alerta

state=`/usr/local/bin/storcli /c0 show  | grep RAID | tail -1 |awk {'print $3'}`

if [ $state == "Optl" ]
then
        echo "OK RAID6 $state" > $control
	exit 0
fi

if [ $state == "Pdgd" ]
then
	echo "Warning: Raid6 Partially Degraded" > $control
fi

if [ $state == "Dgrd" ]
then
	echo "Critical: Raid6 Degraded" > $control
fi


# Enviamos la alerta por mail

RECIPIENTS="miguelangel.sanchez@upf.edu,alfons.gonzalez@upf.edu"
SUBJECT="RAID Error: $host Time: $date"
EMAILMESSAGE="$control"


/bin/mail -s "$SUBJECT" $RECIPIENTS < $EMAILMESSAGE

