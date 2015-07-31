#!/usr/bin/expect

set timeout 30
set host [lindex $argv 0]
set name [lindex $argv 1]
set password [lindex $argv 2]
set node [lindex $argv 3]

#spawn ssh $host -l $name
spawn ssh -l $name $host
expect {
 "password:"
 {send "$password\r"}
 "(yes/no)?"
 {send "yes\r";exp_continue;}
}
sleep 1
send "cd Oracle/Middleware/user_projects/domains/base_domain/bin\r"
send "./stop1.sh\r"
send "./stop2.sh\r"
send "cd ..\r"
send "pwd\r"

#send_user "./S$node-1.sh\n"
send "./S$node-1.sh\r"
#send_user "./S$node-2.sh\n"
send "./S$node-2.sh\r"

send "exit\r"
interact

