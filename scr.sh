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

cat $1 | egrep -v "^$" | cut -d\/ -f7 | sed '/^$/d' |sort -u > $LISTA


for x in `cat $1 | egrep -v "^$" | cut -d\/ -f7 | sort -u`; do
cat $1 | grep $x > /home/$x/arquivos-suspeitos.txt |chown $x: /home/$x/arquivos-suspeitos.txt
done


for y in `cat $LISTA`; do
chown $y: /home/$x/arquivos-suspeitos.txt
done


for w in `cat $1|awk -F: '{printf $1 "\n"}'`;do
chmod 700 $w | echo "$w"| xargs ls -lhap
done

list=$(cat $LISTA| awk -F: '{printf $1 "\n"}')
echo


for z in $list; do
/sbin/locadmin/hospedagem/admin_statusweb $z >> saidaresultado
done

#logindesativados=$(cat saidaresultado| awk -F: '{print $2 $3 "\n"}')

#cat saidaresultado

date +"%d-%m-%Y-%T"; echo >> testefrozen;
for x in `cat arquivocomlogins`; do echo $x; echo >> testefrozen; done
exit 0