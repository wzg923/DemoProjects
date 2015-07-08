#!/usr/bin/expect
set timeout 60
spawn ssh -l weblogic 10.135.12.111
expect "*password:" {send "Neusoft@2015\r"}
interact
