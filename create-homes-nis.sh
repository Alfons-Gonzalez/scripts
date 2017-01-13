#!/bin/sh
# scriptillo per no fer els mkdir a ma
#
LIST=`ypcat passwd | cut -d ':' -f1`
for name in $LIST 
do
        grup=`ypcat passwd|grep $name| cut -d ':' -f4`
#       echo $name
#       echo $grup
        if [ -d /home/$name ]
        then 
                echo "ja existeix el directori de $name"
        else
                mkdir /home/$name
                cp -rp /etc/skel/. /home/$name
                chown -R $name:$grup /home/$name
        fi
done
echo "Ja hem acabat"
ls -l /home
exit 0

