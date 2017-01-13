#!/bin/sh
#
# Definim la funcio suma
suma () # funcio per fer la suma de les dades d'un fitxer
{ 
LIST=`cat $1` # $1 aqui es el primer argument de la funcio
# fem la suma
TOTAL=0
for num in $LIST
        do
                let TOTAL=$TOTAL+$num
        done
echo "La suma dels elements de $1 dona $TOTAL " 
}
# comprovem que l'script te un argument i nomes un
FITXER=$1
if [ $# -ne 1 ] 
then
	echo "Us : $0 fitxer"
	exit 1
fi
# es un fitxer i el fitxer que se li passa existeix 
if [ ! -f $FITXER ]
then
	echo "No trobo $FITXER"
	exit 2
fi
# comprovem que el fitxer efectivament nomes te una columna de nombres
declare -i CONTROL
declare -i COLUMNS
CONTROL=`egrep -ic '[a-z]|\.|\,' $FITXER` # si troba un caracter no numeric sera diferent de 0
COLUMNS=` awk '{print NF}' $FITXER | grep -cv 1` # si troba + d'una columna sera diferent de 0
if [ $CONTROL -eq 0 ] &&  [ $COLUMNS -eq 0 ]
then
	# fem la suma i la assignem a un valor
	result=`suma $FITXER`
else
	echo "el fitxer no es valid per fer la suma: ha d'haver una unica columna amb nombres sencers"
	exit 3
fi
echo "*********************************************************************"
echo $result
echo "*********************************************************************"
exit 0

