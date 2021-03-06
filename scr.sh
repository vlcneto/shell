#!/bin/sh

#versao 0.2 cria lista de logitouchn/file/remove permission (corrigido grep)

exec 2>> log.txt

if [ "$#" -ne 2 ]
then
echo " Use $0 arquivo com o scan e nome da lista"
exit 0
fi

#gera a primeira lista

cat $1 | egrep -v "^$" | cut -d\/ -f7 | sed '/^$/d' |sort -u > prim_lis


#remove os usuarios do sistema e compara com o passwd e gera uma segunda lista

echo -n > result_file

echo -n > origfile
for x in `cat prim_lis |awk -F: '{printf $1 "\n"}'`; do
cat /etc/passwd|cut -d: -f 1 |awk '!/webserver|webserver-logs|locaweb-sudo/'| grep -w $x| sort -u >> origfile
done

#echo -n > lista_login
#Provisorio para remover os logins "_internos"
cat origfile |grep -v '^\_'|sort -u > $2

#verifica o status das hospedagens

echo -n > saidaresultado
(date "+%d-%m-%Y-%T"; echo) >> saidaresultado
    for z in `cat lista_login|awk -F: '{print $1 "\n"}'`; do
/sbin/locadmin/hospedagem/admin_statusweb $z >> saidaresultado
    done
echo >> saidaresultado
echo >> saidaresultado

#compara saida e cria 2 arquivos (ativos e desativados)

listinha=$(cat $2| wc -l)

if [ -e saidaresultado ]; then
    cat saidaresultado |grep "desactivated"| cut -d ' ' -f 2 > desativados
fi
cat $2 > prim_lis3
awk 'FNR==NR{a[$1]++;next}!a[$1]' desativados prim_lis3 >> $2

#remove os desativados da lista de login


for x in `cat $1 | egrep -v "^$" | cut -d\/ -f7 | sort -u`; do
cat $1 | grep -w $x > /home/$x/arquivos-suspeitos.txt |chown $x: /home/$x/arquivos-suspeitos.txt
echo "$x"
done


for y in `cat origfile|awk -F: '{printf $1 "\n"}'`; do
chown $y: /home/$x/arquivos-suspeitos.txt
done

for w in `cat $1|awk -F: '{printf $1 "\n"}'`;do
chmod 700 $w | echo "$w"| xargs ls -lhap
done

for x in `cat $2 |awk -F: '{printf $1 "\n"}'`; do ls -lha /home/$x/|grep "arquivos-suspeitos.txt" >> result_file; done


echo " "
echo " "
echo "Numero total de clientes gerados pelo scan FULL->" $(cat origfile|wc -l)
echo "NUmero total depois dos duplicados e afins->" $listinha
echo "Numero total de clientes desativados->" $(cat desativados|wc -l)
echo "Numero de clientes->" $(cat $2|wc -l)
echo "Numero de arquivos-suspeitos.txt encontrados->" $(cat result_file|wc -l)


rm prim_lis
rm prim_lis3
exit 0