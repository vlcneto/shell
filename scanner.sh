#!/bin/sh

#script para rodar clamscan v.0.1

file=$1
move=$(pwd)

if [[ -f log_scan.txt ]]
then
echo 2> /dev/null
else
touch log_scan.txt
fi

if [ "$#" -ne 1 ]
then
echo " Use $0 nomedoarquivo"
exit 0
fi

renice 19 -p $$ > /dev/null
clamscan -ri --no-summary /home/* >> $move/$1


exit 0