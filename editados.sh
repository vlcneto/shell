#!/bin/bash
#versao 0.1 alpha
#verifica arquivos novos ou alterados nas ultimas 24hrs/scan


if [ "$#" -ne 1 ]
then
echo " Use $0 arquivo de saida / verifica somente o home da maquina"
exit 0
fi

file=$1

renice 19 -p $$ > /dev/null
find /home/ -type f -daystart -ctime 0 > $file
printf "%s\n" "Efetuar o scan y/n"
read CHSE

if [ $CHSE = "y" ]; then
for x in `cat $file|awk -F: '{printf $1 "\n"}'`; do clamscan $x 
done
else
printf "%s\n" "Arquivo com o find em $PWD/$file"
fi




#for x in $file; do cat $file |awk -F: '{printf $1 "\n"}




#printf "%s\n" "$partition"
#printf "%s\n" "$file" 