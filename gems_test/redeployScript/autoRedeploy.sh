#!/bin/bash
#author@guang
#�Զ��Ȳ���weblogic������
#��war��Ԥ���ϴ���ָ��Ŀ¼�£��Զ�ִ��war�ļ�Զ�̸��ƣ��Ȳ�������
#�ɹ�������ɺ��˳���¼
#ִ�У�sh autoRedeploy.sh

read -p "ȷ��Ҫ�����Ȳ�����?[y/n]" answer
case $answer in
 y|Y) echo "Good,continue.";;
 n|N) echo "Ok,googbye.";exit;;
 *) echo "Bad choice.";exit 1;;
esac

#�������
passwd="Neusoft@2015"
dd=$(date "+%Y%m%d%H%M")
version=$(date "+%Y.%m.%d.%H.%M")
#expect�ű���ʼ
/usr/bin/expect << EOF2

spawn ssh -l weblogic 10.135.13.107
expect {
"*yes/no" { send "yes\r"; exp_continue }
"*password:" { send "$passwd\r" }
}
#����ȴ�
sleep 1 
send "cd webapp\r"
send "mv gems-web.war gems-web$dd.war\r"
send "scp weblogic@10.135.12.111:/home/weblogic/deploypackage/gems-web.war ./\r"
expect {
 "*yes/no" { send "yes\r";exp_continue }
 "*password:" {
	send "$passwd\r" 
	#����ȴ����ȴ��ļ��������
	sleep 5
	send "cd bin\r"
	send "cd /home/weblogic/Oracle/Middleware/user_projects/domains/base_domain/bin\r"
	send ". ./setDomainEnv.sh\r"
	send "java weblogic.Deployer -adminurl t3://localhost:7001 -user weblogic -password zaq12wsx -redeploy -name gems -source /home/weblogic/webapp/gems-web.war -appversion $version\r"

 }
}
#����ȴ�
sleep 1
send "exit\r"
interact
expect eof

EOF2
#expect�ű�����
