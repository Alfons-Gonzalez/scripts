#!/bin/sh
# anem a sumar les despeses fetes en material informatic d'un any donat
# ************************************************************************
# 		ATENCIO: ARA MATEIX NO ES POT EXECUTAR TAL COM ESTA
#		PETA PQ A LA BD EL FORMAT EN QUE ENTREM ELS PREUS NO
#		TE CAP CONTROL I HI HA DADES DE l'ESTIL: 9.867,81 € + IVA
#*************************************************************************	
#
YEAR=2012		# escollim any, es podria passar com argument..
# ara fem una consulta mysql
echo "select preu from comandes.comanda where data_com < '$YEAR-12-31 and data_com > '$YEAR-01-01';" | mysql -u alfons > despeses_$YEAR.txt
# treiem la primera linea que conte el nom del camp  
LIST=`cat despeses_$YEAR.txt | sed 1d`
# fem la suma
declare -i TOTAL
TOTAL=0
for num in $LIST 
	do
# AQUI ESTA ARA MATEIX EL PROBLEMA :
# hem de quedar-nos amb els nombres...i treure'ns de sobre caracters raros, text afegit, etc. 
		declare -i num
		TOTAL=$TOTAL+$num
	done
echo "La despesa total l'any $YEAR va ser de $TOTAL euros" 

