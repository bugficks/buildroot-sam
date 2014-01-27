#!/bin/sh

# USB insmod & mount
/etc/Scripts/usb_start.sh
sleep 3

echo "move to root directory..."
cd /

mount -t rfs ${MTD_SWU} /mtd_swu
if [ $? != 0 ]
then
	umount /mtd_swu 2> /dev/null
	fat.format  -F 32 ${MTD_SWU}
	mount -t rfs ${MTD_SWU} /mtd_swu
fi

if [ -e $PARTITION_FLAG00 ]
then
	PART_FLAG="1st partition"
else
	PART_FLAG="2nd partition"
fi

if [ -e /mtd_exe/.info ]
then
	BOARD_INFO=$(cat /mtd_exe/.info)/image
else
	echo "/dtv/info file not found!! set to default T-GASAUSC"
	BOARD_INFO=T-GASAUSC/image
fi

echo "Start usb update!!"
echo "Do not power off nor remove usb before update is finished!!!"
sleep 3
echo -n "Image folder name(enter : "$BOARD_INFO") = "
read directory

if [ "$directory" = "" ]
then
	directory=$BOARD_INFO
fi

echo "Input partition number to update(current partition : "$PART_FLAG")"
echo "1 : 1st partition		2 : 2nd partition"
echo -n "select = "
read partition

if [ "$partition" != "1" ] && [ "$partition" != "2" ]
then
	echo ""
	echo "partition number error"
	exit 1
fi

if [ -e /dtv/usb/sda1 ]
then 
	MDIR=/dtv/usb/sda1
fi
if [ -e /dtv/usb/sda ]
then
	MDIR=/dtv/usb/sda
fi
if [ -e /dtv/usb/sda0 ]
then
	MDIR=/dtv/usb/sda0
fi
if [ -e /dtv/usb/sda2 ]
then
	MDIR=/dtv/usb/sda2
fi
if [ -e /dtv/usb/sdb ]
then
	MDIR=/dtv/usb/sdb
fi
if [ -e /dtv/usb/sdc ]
then
	MDIR=/dtv/usb/sdc
fi
if [ -e /dtv/usb/sdb1 ]
then
	MDIR=/dtv/usb/sdb1
fi
if [ -e /dtv/usb/sdc1 ]
then
	MDIR=/dtv/usb/sdc1
fi

if [ ! -e $MDIR/$directory ]
then
	echo ""
	echo "directory does not exist"
	exit 1
fi

echo "updating $MDIR/$directory/"

echo "deleting $UPDATE_IMG_DIR/0 $UPDATE_IMG_DIR/1"
rm -rf $UPDATE_IMG_DIR/0
rm -rf $UPDATE_IMG_DIR/1


if [ -e $MDIR/$directory/onboot.bin ];then
#    echo "START update onboot.bin"
#    bml.restore ${MTD_ONBOOT_BML}  $MDIR/$directory/onboot.bin 2> /dev/null
#    echo "END update onboot.bin"
#else
    echo "You cannot update onboot.bin."
fi

if [ -e $MDIR/$directory/u-boot.bin ];then
    echo "START update u-boot.bin"
    bml.restore ${MTD_UBOOT_BML}  $MDIR/$directory/u-boot.bin 2> /dev/null
    echo "END update u-boot.bin"
else
    echo "u-boot.bin is not found."
fi

if [ -e $MDIR/$directory/sign0.bin ] && [ "$partition" = "1" ]; then
    echo "START update sign0.bin"
    bml.restore ${MTD_SIGN0_BML}  $MDIR/$directory/sign0.bin 2> /dev/null    
    echo "END update sign0.bin"
elif [ -e $MDIR/$directory/sign1.bin ] && [ "$partition" = "2" ]; then
    echo "START update sign1.bin"
    bml.restore ${MTD_SIGN1_BML}  $MDIR/$directory/sign1.bin 2> /dev/null
    echo "END update sign1.bin"
else
	echo "No sign file or incorrect sign0/1.bin file "
fi

if [ -e  $MDIR/$directory/Image ]
then
    	echo ""
    	echo "START update Image"
    	if [ "$partition" = "1" ]
    	then
        	echo "update 1st partition!!!"
        	bml.restore ${MTD_KERNEL0_BML} $MDIR/$directory/Image 2> /dev/null
    	elif [ "$partition" = "2" ]
    	then
        	echo "update 2nd partition!!!"
        	bml.restore ${MTD_KERNEL1_BML}  $MDIR/$directory/Image 2> /dev/null
    	fi
    	sync
    	echo "END update Image"
else
    	echo "Image is not found."
fi

if [ -e $MDIR/$directory/exe.img ]
then
	echo ""
	echo "START copy exe.img"
	cp $MDIR/$directory/exe.img /mtd_swu
	sync
	echo "END copy exe.img"
else
   	echo "exe.img is not found."
fi

if [ -e $MDIR/$directory/rocommon.img ]
then
        echo ""
        echo "START copy rocommon.img"
		umount /mtd_rocommon 2> /dev/null
        dd if=$MDIR/$directory/rocommon.img of=${MTD_ROCOMMON}
        sync
        echo "END copy rocommon.img"
else
        echo "rocommon.img is not found."
fi

if [ -e  $MDIR/$directory/appext.img ]
then
        echo ""
        echo "START update appext.img"
		umount /mtd_appext 2> /dev/null
        if [ "$partition" = "1" ]
        then
            echo "update 1st partition!!!"
            dd if=$MDIR/$directory/appext.img of=${MTD_APPEXT0} 2> /dev/null
        elif [ "$partition" = "2" ]
        then
            echo "update 2nd partition!!!"
            dd if=$MDIR/$directory/appext.img of=${MTD_APPEXT1} 2> /dev/null
        fi
        sync
	    echo "END update appext.img"
else
        echo "appext.img is not found."
fi

if [ -e $MDIR/$directory/rwcommon.img ]
then
	echo ""
	echo "START copy rwcommon.img"
	cp $MDIR/$directory/rwcommon.img /mtd_swu
	sync
	echo "END copy rwcommon.img"
else
   	echo "rwcommon.img is not found."
fi

if [ -e $MDIR/$directory/emanual.img ]
then
    echo ""
    echo "START copy emanual.img"
    cp $MDIR/$directory/emanual.img /mtd_swu
    sync
    echo "END copy emanual.img"
else
    echo "emanual.img is not found."
fi

if [ -e  $MDIR/$directory/rootfs.img ]
then
        echo ""
        echo "START update rootfs.img"
        if [ "$partition" = "1" ]
        then
            echo "update 1st partition!!!"
            bml.restore ${MTD_ROOTFS0_BML} $MDIR/$directory/rootfs.img 2> /dev/null
        elif [ "$partition" = "2" ]
        then
            echo "update 2nd partition!!!"
            bml.restore ${MTD_ROOTFS1_BML} $MDIR/$directory/rootfs.img 2> /dev/null
        fi
        sync
	    echo "END update rootfs.img"
else
        echo "rootfs.img is not found."
fi

if [ -e  $PARTITION_FLAG00 ] && [ "$partition" = "2" ]; then
   	echo ""
   	echo "toggle to 2nd partition!!!"
   	$MICOM_BASE/toggle 1
   	echo ""
elif [ -e $PARTITION_FLAG10 ] && [ "$partition" = "1" ]; then
   	echo ""
   	echo "toggle to 1st partition!!!"
   	$MICOM_BASE/toggle 0
   	echo ""
fi

touch $SHELL_UPDATE_FLAG
sync
touch $USB_UPDATE_FLAG
sync

echo ""
echo "End copy"
echo "Reboot system..."
$MICOM_BASE/reboot
sleep 3
