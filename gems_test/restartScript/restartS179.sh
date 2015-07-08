#!/usr/bin/expect
set timeout 60
spawn ssh -l weblogic 10.135.17.179
expect "*password:"
send "zaq12wsx\r"
sleep 1
send "cd domain/gems_domain/bin\r"
send "./stopApp1.sh\r"
send "cd ..\r"
send "pwd\r"
send "./startApp1.sh\r"
 

interact

