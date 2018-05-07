#!/usr/bin/expect
spawn telnet localhost 7072
send "\r"
expect "fhem> "
set timeout 120
send "update\r"
expect "fhem> "
send "shutdown\r"
interact
