#!/bin/sh
/sbin/micom usb_gpio

# usb driver insmod
insmod /lib/modules/usbcore.ko
insmod /lib/modules/ohci-hcd.ko
insmod /lib/modules/usb-storage.ko
insmod /lib/modules/ehci-hcd.ko
sleep 3
