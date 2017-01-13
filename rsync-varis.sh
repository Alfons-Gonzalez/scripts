#!/bin/sh
#
# de local a local
rsync -av /origen/ /desti
#
# de remot a local
#
rsync -av user@maquina:/origen/ /desti
#
# de local a remot
rsync -av /origen/ user@maquina:/desti
#
# sincronitzar nomes la estructura de directoris
rsync -v -d /origen/ /desti
#
# veure el progres
rsync -av --progress /origen/ /desti
#
#
# includes i excludes
rsync -av --include 'nom*' --exclude '*' /origen/ /desti
# nomes fara els arxius i dirs que comencin per nom*
#
rsync -av --exclude-from 'exclude-list.txt' /origen/ /desti
# no fara aquells directoris o fitxers que estiguin a l'exclude list
#
# limitar per tamany (no copiar fitxers majors que 100Mb)
rsync -av --max-size='100M' /origen/ /desti
#






