#!/usr/bin/expect
set timeout 30
spawn ssh -l weblogic 10.135.13.110
expect "password:"
send "Neusoft@2015\r"
interact
