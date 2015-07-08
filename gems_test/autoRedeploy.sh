#!/bin/bash
#author@guang
#自动热部署weblogic服务器
#将war包预先上传到指定目录下，自动执行war文件远程复制，热部署命令
#成功部署完成后，退出登录
#执行：sh autoRedeploy.sh

read -p "确定要进行热部署吗?[y/n]" answer
case $answer in
 y|Y) echo "Good,continue.";;
 n|N) echo "Ok,googbye.";exit;;
 *) echo "Bad choice.";exit 1;;
esac

#定义变量
passwd="Neusoft@2015"
dd=$(date "+%Y%m%d%H%M")
version=$(date "+%Y.%m.%d.%H.%M")
#expect脚本开始
/usr/bin/expect << EOF2

spawn ssh -l weblogic 10.135.13.107
expect {
"*yes/no" { send "yes\r"; exp_continue }
"*password:" { send "$passwd\r" }
}
#必须等待
sleep 1 
send "cd webapp\r"
send "mv gems-web.war gems-web$dd.war\r"
send "scp weblogic@10.135.12.111:/home/weblogic/deploypackage/gems-web.war ./\r"
expect {
 "*yes/no" { send "yes\r";exp_continue }
 "*password:" {
	send "$passwd\r" 
	#必须等待，等待文件传输完成
	sleep 5
	send "cd bin\r"
	send "cd /home/weblogic/Oracle/Middleware/user_projects/domains/base_domain/bin\r"
	send ". ./setDomainEnv.sh\r"
	send "java weblogic.Deployer -adminurl t3://localhost:7001 -user weblogic -password zaq12wsx -redeploy -name gems -source /home/weblogic/webapp/gems-web.war -appversion $version\r"

 }
}
#必须等待
sleep 1
send "exit\r"
interact
expect eof

EOF2
#expect脚本结束
