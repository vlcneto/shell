#!/bin/sh
#find normal

if [ "$#" -ne 1 ]
then
echo " Use $0 arquivo com o scan"
exit 0
fi


renice 19 -p $$ > /dev/null
find /home/* -name jce.xml > $1
exit 0