#!/bin/bash
#restart.sh ������������������������1̨���������������Ӳ��Գɹ���������һ̨

echo "��������������\n"

./restartWithParam.sh 10.135.13.107 weblogic Neusoft@2015
./requestUrl.sh 10.135.13.107:6001/gems/
./requestUrl.sh 10.135.13.107:6002/gems/

./restartWithParam.sh 10.135.13.108 weblogic Neusoft@2015
./requestUrl.sh 10.135.13.108:6001/gems/
./requestUrl.sh 10.135.13.108:6002/gems/

./restartWithParam.sh 10.135.13.109 weblogic Neusoft@2015
./requestUrl.sh 10.135.13.109:6001/gems/
./requestUrl.sh 10.135.13.109:6002/gems/

./restartWithParam.sh 10.135.13.110 weblogic Neusoft@2015
./requestUrl.sh 10.135.13.110:6001/gems/
./requestUrl.sh 10.135.13.110:6002/gems/

echo "�������������\n"
exit
