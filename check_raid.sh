#!/bin/sh
#
state=`/usr/local/bin/storcli /c0 show  | grep RAID | tail -1 |awk {'print $3'}`

if [ $state == "Optl" ]
then
	echo "OK RAID6 $state"
	exit 0
fi

if [ $state == "Pdgd" ]
then
	echo "Warning: Raid6 Partially Degraded"
	exit 1
fi

if [ $state == "Dgrd" ]
then
	echo "Critical: Raid6 Degraded"
	exit 2
fi

