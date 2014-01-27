#!/bin/sh

echo "network_init start"

# insmod net driver
if [ -f /lib/modules/r8101.ko ]
then
        insmod /lib/modules/r8101.ko
else
        insmod /lib/modules/sdp_mac.ko
fi

# local loopback
ifconfig lo 127.0.0.1
