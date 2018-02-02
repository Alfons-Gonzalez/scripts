#!/bin/sh
# 
# script per fer un check dels volums del gluster
#
LLISTA=`gluster volume info | grep Volume | grep Name | awk '{ print $3}'`
for VOL in $LLISTA
	do
	   ESTAT=`gluster volume info $VOL | grep Status | awk '{print $2}'`
	   if [ "$ESTAT" == "Started" ]
	   then
		echo "$VOL OK"
	   else
		echo "$VOL No OK"
	   fi
	done


