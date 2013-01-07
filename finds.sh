#!/bin/sh
#find com verifica versao

find /home/ -name jce.xml > lista.txt

for x in `cat lista.txt`; do
   version=`cat ${x} | grep "<version>" | sed 's/<\/*\w*>//g' | sed 's/[^0-9]*//g'`
   if [ ${version:0:3} -lt 231 ]; then
      echo ${x} | cut -d"/" -f7 >> saida.txt
   fi
done
cat saida.txt |sort -u; rm lista.txt