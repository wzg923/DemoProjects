#!/usr/bin/expect
set timeout 60
spawn ssh -l weblogic 10.135.12.111
expect "*password:"
send "Neusoft@2015\r"
sleep 1
send "cd domain/gems_domain/bin\r"
send "./stopApp1.sh\r"
send "cd ..\r"
send "pwd\r"
send "./startApp1.sh\r"
 

interact

