#!/bin/sh
#
# de moment no es un script...vaig a veure si podem automatitzar les passes
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
        exit 
fi
# segons el labo canvien algunes variables
case $LAB in
	ibi) NIS_SERVER=bradbury; NFS_SERVER=alfa; echo $NIS_SERVER ;;
	cadd) NIS_SERVER=carver; NFS_SERVER=alfa; echo $NIS_SERVER ;;
	cgl)  NIS_SERVER=miggins; NFS_SERVER=beta; echo $NIS_SERVER ;;
	cslab) NIS_SERVER=kauffman; echo $NIS_SERVER ;;
	genomics)  NIS_SERVER=cortazar; NFS_SERVER=beta;echo $NIS_SERVER ;;
	multiscale)  NIS_SERVER=orwell; echo $NIS_SERVER ;;
	sbi)  NIS_SERVER=borges; NFS_SERVER=beta; echo $NIS_SERVER ;;
	cbbl)  NIS_SERVER=vitis1; NFS_SERVER=alfa; echo $NIS_SERVER ;;
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
# passes seguents:
# 2.- crear directori i usuari sense shell als servidors nfs del lab
if [[ $NFS_SERVER ]]
	then
	"echo creant directori a $NFS_SERVER"
	ssh $NFS_SERVER "useradd -u $USER_ID -g $GROUP_ID -M -s /sbin/nologin $USER_NAME; mkdir /$LAB/users/$USER_NAME; chown $USER_ID:$GROUP_ID /$LAB/users/$USER_NAME"
fi
# i a pandora, el servidor de backup, excepte per multiscale, que no el fa servir
if [ $LAB = multiscale ]
	then echo "Fet: Falta crear usuari a apolo i crear /home/$USER_NAME a la seva ws"; exit
fi
ssh pandora "useradd -u $USER_ID -g $GROUP_ID -M -s /sbin/nologin $USER_NAME; mkdir /$LAB/users/$USER_NAME; chown $USER_ID:$GROUP_ID /$LAB/users/$USER_NAME"
# 
# 3.- crear usuari a apolo (no ho podrem fer automaticament)
# 4.- els grups que tenen cluster (genomica,cgl,sbi) crear usuari al NIS del cluster
echo "Fet: Falta crear usuari a apolo i crear /home/$USER_NAME a la seva ws"
exit 0



