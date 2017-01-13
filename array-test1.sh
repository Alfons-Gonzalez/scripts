#!/bin/sh
#
array1=( alfa beta gamma )
array2=( A B C )
i=0
while [ $i -lt 3 ]
do
        echo ${array1[$i]} ${array2[$i]}
        i=` expr $i + 1`
done


