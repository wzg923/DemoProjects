#!/bin/bash
#requestUrl.sh

#ping测试连接是否成功,测试连接成功返回0,失败返回1
function pingUrl(){
echo -e "[$(date +'%Y-%m-%d %H:%M:%S')]Request URL:$1\t";
http_code=`curl -o /dev/null --connect-timeout 10 --retry 3 --retry-delay 0 --retry-max-time 10  -s -w "%{http_code}\n" "$1"`
#echo $http_code;
if [ $http_code -eq 200 ]
then
 echo -e "connect success!\t"
  return 0
else
 echo -e "connect failed!\t"
  return 1
fi

}


flag=1
while [[ "$flag" -ne 0 ]]
do
  pingUrl $1
  flag=$?
  if [ "$flag" -ne 0 ]
  then 
	sleep 5;
  fi
done


