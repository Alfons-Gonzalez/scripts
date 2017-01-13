#!/bin/sh
OLD_UID=600
NEW_UID=500
DIR=/home/alfons/zz
cd $DIR;
find . -uid $OLD_UID -exec chown $NEW_UID {} \;
