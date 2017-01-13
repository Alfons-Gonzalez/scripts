#!/bin/bash
#
# first argument is .gz file, second arg is the file containing patterns
#
if [ $# -lt 2 ]
then
	echo "Usage: $0 file_to_search.gz file_with_patterns.txt"
	exit 1
fi
PATTERNS=`cat $2`


zcat $1 | while read line
	do
		for pattern in $PATTERNS
			do
				echo $line | grep $pattern 2> /dev/null # don't care about errs
			done
	done

exit 0



