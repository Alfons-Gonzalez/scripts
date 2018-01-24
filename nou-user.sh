#!/bin/sh
#
# 
#
# 
# 1.- donar d'alta l'usuari al nis del seu labo
USER_NAME=$1
USER_ID=$2
GROUP_ID=$3
LAB=$4
# Check que ens donen 4 arguments  #
if [ $# -lt 4 ]
then
        echo " Us: $0 nom_usuari uid gid lab"
	echo " lab pot ser: ibi,phi,gpcr,cgl,multiscale,cslab"
        exit 
fi
# segons el labo canvien algunes variables
case $LAB in
	ibi) NIS_SERVER=bradbury; NFS_SERVER=alfa; echo $NIS_SERVER ;;
	phi) NIS_SERVER=carver; NFS_SERVER=alfa; echo $NIS_SERVER ;;
	gpcr) NIS_SERVER=carver; NFS_SERVER=alfa; echo $NIS_SERVER ;;
	cgl)  NIS_SERVER=wilde; NFS_SERVER=beta; echo $NIS_SERVER ;;
	genomics)  NIS_SERVER=cortazar; NFS_SERVER=beta;echo $NIS_SERVER ;;
	sbi)  NIS_SERVER=borges; NFS_SERVER=beta; echo $NIS_SERVER ;;
	multiscale)  NIS_SERVER=orwell; echo $NIS_SERVER ;;
	cslab) NIS_SERVER=asimov; echo $NIS_SERVER ;;
	*) echo "$LAB es un nom de labo incorrecte" ; exit ;;
esac
#
# check que no esta repetit
LIST="$USER_NAME $USER_ID"
for value in $LIST 
do
	CONTROL=`ssh $NIS_SERVER "grep $value /etc/passwd" `
	if [[ $CONTROL ]]
		then
		echo "Error: $value repetit" ; echo "$CONTROL"; exit 
	fi
done
#
#echo "si no ha trobat repeticio seguim..."
echo "creant $USER_NAME a $NIS_SERVER"
ssh $NIS_SERVER "useradd -u $USER_ID -g $GROUP_ID $USER_NAME; cd /var/yp; make"
#
# 2.- 
echo "creant el directori de l'usuari a les workstations de grup"
ansible $LAB -m file -a "path=/home/$USER_NAME state=directory owner=$USER_NAME group=$GROUP_ID"
ansible $LAB -m copy -a "src=/etc/skel/.bashrc dest=/home/$USER_NAME/.bashrc"
ansible $LAB -m copy -a "src=/etc/skel/.bash_profile dest=/home/$USER_NAME/.bash_profile"

# passes seguents:
# 3.- crear directori i usuari sense shell als servidors nfs del lab
if [[ $NFS_SERVER ]]
	then
	echo "creant directori a $NFS_SERVER"
	ssh $NFS_SERVER "useradd -u $USER_ID -g $GROUP_ID -M -s /sbin/nologin $USER_NAME; mkdir /$LAB/users/$USER_NAME; chown $USER_ID:$GROUP_ID /$LAB/users/$USER_NAME"
fi
# i a pandora, el servidor de backup, excepte per multiscale, que no el fa servir
if [ $LAB = multiscale ]
	then echo "Fet: Falta crear usuari a zeus"; exit
fi
ssh pandora "useradd -u $USER_ID -g $GROUP_ID -M -s /sbin/nologin $USER_NAME; mkdir /$LAB/users/$USER_NAME; chown $USER_ID:$GROUP_ID /$LAB/users/$USER_NAME"
# 
# 4.- crear usuari a zeus (no ho podrem fer automaticament)
echo "Fet: Falta crear usuari a zeus i posar passwd"
exit 0



