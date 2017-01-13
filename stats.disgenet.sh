#!/bin/bash
# treure stats de descarregues per Janet

# fitxers per disgenet

FITXERS_Dis=" DisGeNET.db.gz DisGeNET.jar DisGeNET_2014.db.gz DisGeNET_2015.db.gz all_gene_disease_associations.tar.gz befree_gene_disease_associations.tar.gz curated_gene_disease_associations.tar.gz literature_gene_disease_associations.tar.gz gene-disease-associations-disgenet-2014.tab.gz " 


# per psygenet
FITXERS_Psy="all_GeneDiseaseAssociations.tar.gz"

for fit in $FITXERS_Dis
do
echo "descarregues de $fit" > disgenet.$fit.log
egrep 'Aug/2014|Sep/2014|Oct/2014' /usr/local/apache2/logs/access_log-old | grep $fit| grep 200 >> disgenet.$fit.log
grep $fit /usr/local/apache2/logs/access_log | grep 200 >> disgenet.$fit.log 
done

for fit in $FITXERS_Psy
do
echo "descarregues de $fit" > psygenet.$fit.log
egrep 'Aug/2014|Sep/2014|Oct/2014' /usr/local/apache2/logs/access_log-old | grep $fit| grep 200 >> psygenet.$fit.log
grep $fit /usr/local/apache2/logs/access_log | grep 200 >> psygenet.$fit.log
done
