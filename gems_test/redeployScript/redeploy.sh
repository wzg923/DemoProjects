#!/usr/bin/expect
#redeploy.sh
#author@guang
#自动热部署weblogic服务器
#将war包预先上传到指定目录下，自动执行war文件远程复制，热部署命令
#成功部署完成后，需手动退出登录
#执行：sh redeploy.sh

set timeout 60
set dd [exec date "+%Y%m%d%H%M"]
set version [exec date "+%Y.%m.%d.%H.%M"]
spawn ssh -l weblogic 10.135.13.107
expect "password:"
send "Neusoft@2015\r"
sleep 1
send "cd webapp\r"
send "mv gems-web.war gems-web$dd.war\r"
send "scp weblogic@10.135.12.111:/home/weblogic/deploypackage/gems-web.war ./\r"
#expect "*Are you sure you want to continue connecting (yes/no)?"
#send "yes\r"
expect "*password:"
send "Neusoft@2015\r"
#send "zaq12wsx\r"
sleep 3
send "cd bin\r"
send "cd /home/weblogic/Oracle/Middleware/user_projects/domains/base_domain/bin\r"
send ". ./setDomainEnv.sh\r"
send "java weblogic.Deployer -adminurl t3://localhost:7001 -user weblogic -password zaq12wsx -redeploy -name gems -source /home/weblogic/webapp/gems-web.war -appversion $version\r"

interact
