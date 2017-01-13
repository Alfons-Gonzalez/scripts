#!/bin/sh
# per fer una copia amb cpio d'arxius modificats fa menys de 24h 
#
cd /directori_origen
find . -mtime -1 -print | cpio -pmdv  /dir_desti

