#!/bin/sh
# per fer una copia amb cpio
#
cd /directori_origen
find . -print | cpio -pmdv  /dir_desti

