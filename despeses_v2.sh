#!/bin/sh
# anem a sumar les despeses fetes en material informatic d'un any donat
# ************************************************************************
# 		ATENCIO: ARA MATEIX NO ES POT EXECUTAR TAL COM ESTA
#		PETA PQ A LA BD EL FORMAT EN QUE ENTREM ELS PREUS NO
#		TE CAP CONTROL I HI HA DADES DE l'ESTIL: 9.867,81 € + IVA
#*************************************************************************	
#
# Definim la funcio suma
suma ()
{
LIST=`cat $1 | sed 1d` # treiem la primera linea 
#
# AQUI ESTA ARA MATEIX EL PROBLEMA :
# hem de  treure'ns de sobre caracters raros, text afegit, etc. 
TOTAL=0
for num in $LIST
        do
                let TOTAL=$TOTAL+$num
        done
echo "La suma dona $TOTAL " 
}

YEAR=2013 # escollim any, es podria passar com argument..
# ara fem una consulta mysql
echo "select preu from comandes.comanda where data_com < '$YEAR-12-31' and data_com > '$YEAR-01-01';" | mysql -u alfons > despeses_$YEAR.txt
# fem la suma
suma despeses_$YEAR.txt

