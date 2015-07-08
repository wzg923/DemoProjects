#!/usr/bin/expect
set timeout 30
spawn ssh -l weblogic 10.135.13.110
expect "password:"
send "Neusoft@2015\r"
sleep 1
send "cd Oracle/Middleware/user_projects/domains/base_domain/bin\r"
send "./stop1.sh\r"
send "./stop2.sh\r"
send "cd ..\r"
send "pwd\r"
send "touch test2.txt\r"
send "./S110-1.sh\r"
send "./S110-2.sh\r"
#sleep 1
send "exit\r"
interact

