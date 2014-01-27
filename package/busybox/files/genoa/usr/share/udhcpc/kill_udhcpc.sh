#!/bin/sh
ps | grep default.script | grep -v grep | while read child_pid others
do
    echo "Killing child process $child_pid of udhcpc"
    kill -9 $child_pid
done
