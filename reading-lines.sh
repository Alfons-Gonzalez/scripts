#!/bin/sh
datafile=/home/alfons/z/1
{
while read line 
do
	grep linea $line 2>/dev/null
done
} <"$datafile"
