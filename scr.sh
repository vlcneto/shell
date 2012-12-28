#!/bin/sh

#versao 0.1 cria lista de login/file/remove permission

exec 2>> log.txt

if [ "$#" -ne 1 ]
then
echo " Use $0 arquivo com o scan"
exit 0
fi

echo "informe o nome da lista"

read LISTA

cat $1 | egrep -v "^$" | cut -d\/ -f7 | sort -u > $LISTA


for x in `cat $1 | egrep -v "^$" | cut -d\/ -f7 | sort -u`; do
cat $1 | grep $x > /home/$x/arquivos-suspeitos.txt |chown $x: /home/$x/arquivos-suspeitos.txt
done


for y in `cat $LISTA`; do
chown $y: /home/$x/arquivos-suspeitos.txt
done


for w in `cat $1|awk -F: '{printf $1 "\n"}'`;do
chmod 700 $w | echo "$w"| xargs ls -lhap
done

exit0


#echo "$result"

#sed '/^$/d' > dor.txt

#cat $1 |awk -F: '{print $1}' $1 | xargs chmod 000;awk -F: '{print $1}' $1 | xargs ls -lhap; echo " "

#for x in '$1 | egrep -v "^$" | cut -d\/ -f7 | sort -u'; do cat $1 | grep $x > /home/$x/arquivos-maliciosos.txt |chown $x: /home/$x/arquivos-maliciosos.txt; done#for x in `$LISTA; awk -F: '{print $1}' $LISTA`; do ls -lhap /home/$x/ |grep arquivos-maliciosos.txt > contralista.txt; done