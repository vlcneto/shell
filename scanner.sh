scanner.sh

#!/bin/sh

#script para rodar clamscan v.0.1

file=$1

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
clamscan -ri /home/* >> /tmp/$1

cp /tmp/$1 . 

#for x in `$1 | egrep -v "^$" | cut -d\/ -f7 | sort -u`; do cat $1 | grep $x > /home/$x/arquivos-maliciosos.txt |chown $x: /home/$x/arquivos-maliciosos.txt
#31::q!done









# ($date +%Y%m%d-%H%M) Pode ser usado para criar a saida de um arquivo







#while 
#ps aux|grep clamscan > /dev/null
#do 
#sleep 30
#echo $!
#jobs
#done
#Echo "fim do clamscan verifique o scan.txt"