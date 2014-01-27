#!/bin/sh

ifconfig lo 127.0.0.1

if [ -f /lib/modules/r8101.ko ]; then
	insmod /lib/modules/r8101.ko
else
	insmod /lib/modules/sdp_mac.ko
fi



