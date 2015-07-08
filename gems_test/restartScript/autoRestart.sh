#!/bin/bash
#author:guang
#autoRestart.sh ������������������������1̨�����������ڵ㣬�������Ӳ��Գɹ���������һ̨
#�����ļ� scp.conf
#ssh_hosts=("1.1.1.1" "2.2.2.2")
#ssh_ports=("22" "22") �������ȱʡ��ȱʡֵΪ22,���߸�����ssh_hosts��ʱ��ʹ��ȱʡֵ
#ssh_users=("root" "root") �������ȱʡ��ȱʡֵΪroot��,���߸�����ssh_hosts��ʱ��ʹ��ȱʡֵ
#ssh_passwords=("323" "222") �������ȱʡ��ȱʡ�Ļ���Ҫ������������,���߸�����ssh_hosts��ʱ��ʹ������������
#ִ�У�sh autoRestart.sh 

read -p "ȷ��Ҫ������������(Y/N)?:" answer
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

#Ĭ�������ļ�
conf_file="host.conf"
default_ssh_user="weblogic"

#�ж�conf_file�����ļ��Ǵ���
if [ ! -e "$conf_file" ]
then
echo "$conf_file is not exists";
exit;
fi

#read configure file
source $conf_file
#����û���������ļ����ṩ���룬��������������
if [ "${#ssh_passwords[@]}" = "0" ] || [ "${#ssh_passwords[@]}" -lt "${#ssh_hosts[@]}" ]
then
read -p "please input password:" -s default_ssh_password
fi

echo "====������������ʼ===="
#ѭ����ȡ�����ļ���Ϣ
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
	
	#ִ�з�������������
        echo "ѭ��host��Ϣ:$ssh_host"
	node=`echo $ssh_host|awk -F '.' '{print $4}'`
	#echo $node
	./restartWithParam.sh $ssh_host $ssh_user $ssh_password $node
	#�����������ӣ�ѭ������ֱ�����ӳɹ�
	./requestUrl.sh $ssh_host:6001/gems/
	./requestUrl.sh $ssh_host:6002/gems/
	fi	
done

echo "====�������������===="
exit
