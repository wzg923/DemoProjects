#!/bin/bash
#author:guang
#autoRestart.sh 重启生产服务器，依次重启1台服务器两个节点，网络连接测试成功后，重启下一台
#配置文件 scp.conf
#ssh_hosts=("1.1.1.1" "2.2.2.2")
#ssh_ports=("22" "22") 这个可以缺省，缺省值为22,或者个数比ssh_hosts少时，使用缺省值
#ssh_users=("root" "root") 这个可以缺省，缺省值为root，,或者个数比ssh_hosts少时，使用缺省值
#ssh_passwords=("323" "222") 这个可以缺省，缺省的话需要从命令行输入,或者个数比ssh_hosts少时，使用命令行输入
#执行：sh autoRestart.sh 

read -p "确定要重启服务器吗(Y/N)?:" answer
case $answer in
 Y|y|yes|YES|Yes)
     echo "fine,continue.";;
 N|n|no|NO|No)
     echo "ok,good bye";
	 exit 0;;
 *)
    echo "error choice";
	exit 1;;
esac

#默认配置文件
conf_file="host.conf"
default_ssh_user="weblogic"

#判断conf_file配置文件是存在
if [ ! -e "$conf_file" ]
then
echo "$conf_file is not exists";
exit;
fi

#read configure file
source $conf_file
#若是没有在配置文件里提供密码，则在命令行输入
if [ "${#ssh_passwords[@]}" = "0" ] || [ "${#ssh_passwords[@]}" -lt "${#ssh_hosts[@]}" ]
then
read -p "please input password:" -s default_ssh_password
fi

echo "====重启服务器开始===="
#循环读取配置文件信息
for((i=0;i<${#ssh_hosts[@]};i++))
do
	#remote ssh host
	ssh_host=${ssh_hosts[$i]};
	if [ "$ssh_host" != "" ]
	then			
		#remote ssh user
		ssh_user=${ssh_users[$i]};
		if [ "$ssh_user" = "" ]
		then
		ssh_user=$default_ssh_user; #use default value
		fi
		#remote ssh password
		ssh_password=${ssh_passwords[$i]};
		if [ "$ssh_password" = "" ]
		then
		ssh_password=$default_ssh_password; #use default value
		fi
	
	#执行服务器重启操作
        echo "循环host信息:$ssh_host"
	node=`echo $ssh_host|awk -F '.' '{print $4}'`
	#echo $node
	./restartWithParam.sh $ssh_host $ssh_user $ssh_password $node
	#测试网络连接，循环请求，直到连接成功
	./requestUrl.sh $ssh_host:6001/gems/
	./requestUrl.sh $ssh_host:6002/gems/
	fi	
done

echo "====服务器重启完成===="
exit
