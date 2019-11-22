#!/bin/sh
#
# La idea es poder fer un share d'un subfolder de MarGenomics 
# per un usuari extern: crearem l'usuari i farem un mount
# del folder al subdirectori $HOME/data del nou usuari en ro
#
# Variables d'input necessaries
USER_NAME=$1
USER_ID=$2
COMMENT=$3
DIR2SHARE=$4

if [ $# -lt 5 ]
then
        echo " Us: $0 nom_usuari uid comment dir2share"
	echo " exemple: $0 acastells 2506 'Anna Castells' /bicoh/MARGenomics/20190524_POrtega_RNASeq_microbH_Mouse/ReadMapping/BAM_Files"
        exit 
fi


# creem usuari a zeus
useradd -u $2 -g 2200 -c $3 $1

# creem el punt de muntatge
su - $1 -c "mkdir $HOME/data"

# fem l'export a dakar
ssh dakar "echo '$4 apolo.prib.upf.edu(ro,no_root_squash,no_subtree_check,nohide)' >> /etc/exports && exportfs -rav"

# muntem el directori
mount dakar:$4 /home/$1/data

# programem desmuntar-lo en 7 dies
at 9:00h +7 days <<< "umount /home/$1/data"

# sortim
echo "hem acabat, cal posar password a $1"
