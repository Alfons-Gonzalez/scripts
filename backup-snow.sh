#!/bin/sh
# backup de snow (sistema gestio cluster)
#
# 1.- configuracio del node /etc i llista de paquets instalats
DATA=`date +%b`
mkdir -p /sNow/backup/$DATA
DESTDIR=/sNow/backup/$DATA
cd /etc && tar zcvf  $DESTDIR/etc.tgz .
dpkg --get-selections | awk ' {print $1 }' | xargs > $DESTDIR/package-list.txt

# sNow filesystem
cd /sNow && tar --exclude=backup/* -zcvf  $DESTDIR/sNow.tgz .

# snow VMs
# creem una llista de les vm
LLISTA_VM=`snow list domains | grep -v Domain| awk '{print $1}'`
# fem els snapshots
for domini in $LLISTA_VM
do
        lvcreate -s -L 1G -n $domini-snap snow_vg/$domini-disk
done
# llistem els snapshots
LLISTA_LV=`lvs | grep snap | awk '{print $1}'`
# fem el backup
for i in $LLISTA_LV
do
        dd if=/dev/snow_vg/$i of=$DESTDIR/$i.vm.img
done
# podem eliminar els snapshots
for i in $LLISTA_LV
do
        lvremove -f snow_vg/$i
done
# copiem el backup elsewhere
ssh marvin 'mkdir /gpfs/HPCNOW/snow01/$DATA'
cd $DESTDIR
scp * root@marvin:/gpfs/HPCNOW/snow01/$DATA


