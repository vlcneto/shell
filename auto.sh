#!/bin/sh
#versao 0.1 alpha
#verifica arquivos novos ou alterados nas ultimas 24hrs/scan - sem nenhuma interaçao

file=$1

echo > datafile
renice 19 -p $$ > /dev/null
for x in `find /home/ -type f -daystart -ctime 0|awk -F: '{printf $1 "\n"}'`; do
clamscan --no-summary $x >> datafile
done

if grep -w "FOUND" datafile; then
    echo " " |mail -s "$HOSTNAME possui arquivos infectados" victor.neto@locaweb.com.br
else
    echo "not found"
fi

exit 0