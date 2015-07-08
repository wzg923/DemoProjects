#!/usr/bin/expect
set timeout 60
spawn ssh -l weblogic 10.135.17.179
expect "*password:" {send "zaq12wsx\r"}
interact
