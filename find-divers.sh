#!/bin/sh
# top 5 bigfiles
 find . -type f -exec ls -sh {} \; | sort -n -r | head -5
# especificar a quin nivell i ignorant el 'case' del nom
find -mindepth 3 -maxdepth 5 -iname "PaSsWD" -print
# trobar els mes grans de 100Mb
find ~ -size +100M
# els modificats l'ultima hora
find -mmin -60 -exec ls -l {} \;
# els que es van modificar despres de modificar el fitxer X
find -cnewer /path/X
# invertir el resultat 
find . -not -iname "aquest_fitxer_no.txt" 
# fitxers ocults
find . -type f -name ".*"
# substituint espais en blanc al nom dels .docx per _
find . -type f -iname '*.docx' -exec rename “s/ /_/g” {} \;


