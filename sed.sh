#!/bin/sh
# sed syntax


# 5 maneres per substituir string1 per string2 a file1
# 1
cp file1 file1.bak
sed 's/string1/string2/' file1.bak > file1
# 2
cat file1 | sed 's/string1/string2/' > file1
# 3
sed -i 's/string1/string2/' file1
# 4 aquesta darrera crea un fitxer file1.bak amb el contingut original
sed -i.bak 's/string1/string2/' file1
# 5 per replacements multiples
sed -i.bak -e 's/string1/string2/' -e 's/string3/string4/' file1

# per esborrar linees

sed 3d file1 # esborra la tercera linea i printa la resta a stdout
sed '3~2d' file1 # esborra a partir de la tercera i cada 2 (i.e la 5,7,9...)
sed '4,8d' file1 # esborra entre les 4
sed '/pattern/d' file1 # esborra la linea que fa match amb pattern
sed '/pattern/,$d' file1 # esborra desde la linea que fa match amb pattern fins al final
sed '/^$/d' file1 # esborra linees en blanc

