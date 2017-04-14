#!/bin/bash
echo "File is being generated do not stop this script!"
cd /ua13app/lifeua/ecom/scripts/ROD_Q/

path_src=/ua13app/lifeua/ecom/scripts/ROD_Q
path_out=/ua13app/lifeua/ecom/scripts/ROD_Q/OUT
file_log=/ua13app/lifeua/ecom/scripts/ROD_Q/LOG/ROD_Q.log

#kto=`whoami`
#if [ "${kto}" != "edekua" ]; then
#echo "skrypt odpalil ${kto}" >> ${file_log}
#echo "Invalid user to run this script!!! You must be logged as edekua"
#exit
#else
#echo "${kto}" >> ${file_log}
#fi

. /ua13app/lifeua/.unims

file_name=rod_q_ecl_`date +'%d%m%Y%H%M'`

czas=`date +'%H%M%S'`

echo "`date` ************START************" >> ${file_log}
echo `id` >> ${file_log}

echo "file ${file_log} start created at `date`" >> ${file_log}

usu edekua rod_q_ecl_sql.sh >> ${path_out}/${file_name}.txt

echo "file ${file_name} end creation at `date`" >> ${file_log}
sleep 30
echo "`date` file is generated" >> ${file_log}
echo "file generated"

iconv -f utf8 -t cp1251 ${path_out}/${file_name}.txt > ${path_out}/${file_name}.csv
sleep 5
echo "`date` file is converted" >> ${file_log}
echo "file converted"
rm ${path_out}/${file_name}.txt

${path_src}/rod_q_ecl_mail.sh "${path_out}/${file_name}.csv" > /dev/null >> ${file_log}
echo "`date` mail script has been accompished" >> ${file_log}
echo "mail sent"

rm ${path_out}/${file_name}.csv

echo "`date` ************STOP************" >> ${file_log}
echo "done"
