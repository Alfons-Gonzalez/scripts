#!/bin/sh
#
# info al /etc/mtab
remotes=`grep sshfs /etc/mtab | awk {'print $1'}`
# aixo pot ser una llista si hi ha mes d'un punt de muntatge sshfs

for muntatge in $remotes
	do
	proces=`ps aux | grep $muntatge | grep -v grep| awk {'print $2'}`
	usuari=`ps aux | grep $muntatge | grep -v grep| awk {'print $1'}`
	puntdemuntatge=`grep $muntatge /etc/mtab | awk {'print $2'}`
	control=`df -h | grep $puntdemuntatge | grep -c "Transport endpoint is not connected" `
	echo $control
	# desmuntem el filesystem si encara esta al mtab pero ja no esta muntat
	if [ $control -gt 0 ]; then
		su - $usuari -c "fusermount -u $puntdemuntatge"
	fi
	done

