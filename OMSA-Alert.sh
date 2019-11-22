#!/bin/sh

# Script que ejecutará Dell OpenManage Server Administrator cada
# vez que se de una alarma en el server.

# Este script mira cual ha sido el error usando la utilidad omreport
# y envia el error por mail.

omreport='/opt/dell/srvadmin/bin/omreport'
tmp_path='/tmp'

# Obtenemos la información de la alerta

desc=`$omreport system alertlog 2>/dev/null | grep "Description" | head -1 | cut -f2-9 -d: | sed 's/ //'`
date=`$omreport system alertlog 2>/dev/null | grep "Date and Time" | head -1 | cut -f2-9 -d:`
host=`$omreport system summary 2>/dev/null | grep "Host Name" | head -1 | cut -f2-9 -d: | sed 's/ //'`
tag=`$omreport system summary 2>/dev/null | grep "Chassis Service Tag" | head -1 | cut -f2-9 -d: | sed 's/ //'`

# Enviamos la alerta por mail

RECIPIENTS="miguelangel.sanchez@upf.edu,alfons.gonzalez@upf.edu"
SUBJECT="System Error: $host Time: $date"
EMAILMESSAGE="$tmp_path/emailmessage.txt"

echo -e " Host: $host \n SvcTag: $tag \n Error: $desc \n Time: $date" > $EMAILMESSAGE

/bin/mail -s "$SUBJECT" $RECIPIENTS < $EMAILMESSAGE
