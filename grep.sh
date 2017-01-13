#!/bin/sh
#
# grep examples

# ignorar el case
grep -i "string" FILE
# buscant la paraula exacte i no una substring
grep -iw "exact" FILE
# ensenya N linees despres del match
grep -A 3 -i "el match i 3 mes" FILE
# idem pero abans
grep -B  -i "el match i 3 mes" FILE
# invert match
grep -v "aixo_no" file
# ensenya les linees que no contenen 'string1' ni 'string2'
grep -v -e "string1" -e "string2" FILE
# comptar el nombre de matches
grep -c "string1" FILE
# nomes ensenya el nom dels fitxers que contenen string1 dins
grep -l "string1" *
# ensenya el numero de linea
grep -n "string1" FILE
# busca string1 o string2
grep 'string1\|string2' FILE
egrep 'string1|string2' FILE
grep -e string1 -e string2 FILE
# busca string1 i string2
grep -E 'string1.*string2|string2.*string1' FILE

