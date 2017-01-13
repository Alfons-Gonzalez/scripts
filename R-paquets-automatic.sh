#!/bin/sh
# 
# mirem els paquets de la distro anterior
Rprevia=/soft/R/R-2.15.2
Rnova=/soft/R/R-2.15.3

# llista de paquets que estan a la versio anterior

LIST=`diff $Rnova/lib64/R/library $Rprevia/lib64/R/library | grep Only | grep $Rprevia| cut -d ':' -f2`

# control : echo $LIST

# contruim el update.R

echo 'source("http://bioconductor.org/biocLite.R")' > update.R

for paquet in $LIST 
do
	#echo $paquet
	echo "biocLite(\"$paquet\")" >> update.R
done

# executem el update.R en batch

$Rnova/bin/R CMD BATCH update.R 

# un cop acabat comprovem si hi ha paquets que no s'han pogut instal.lar
diff $Rnova/lib64/R/library $Rprevia/lib64/R/library | grep Only | grep $Rprevia> paquets.failed.txt

echo "Cal comprovar si hi ha paquets a paquets.failed.txt, i si cal, instal.lar-los a ma"


