#!/bin/bash
#restart.sh 重启生产服务器，依次重启1台服务器，网络连接测试成功后，重启下一台

echo "重启生产服务器\n"

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

echo "服务器重启完成\n"
exit
