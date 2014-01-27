#!/bin/sh

echo "updating flash Images"
$MICOM_BASE/ledon

if [ -e $SHELL_UPDATE_FLAG ]
then
    echo "UPDATE.SH UPDATE"
else
    if [ -e $USB_UPDATE_FLAG ]
    then
        echo "SW UPDATE"

        if [ -e $PARTITION_FLAG00 ]
        then
            UPDATE_IMG_DIR=$UPDATE_IMG_DIR/0
        elif [ -e $PARTITION_FLAG10 ]
        then
            UPDATE_IMG_DIR=$UPDATE_IMG_DIR/1
        fi
    fi
fi

echo "Update image Dir = $UPDATE_IMG_DIR"

if [ -e $UPDATE_IMG_DIR/exe.img ]
then
	echo ""
	echo "START update exe.img"
	umount /mtd_exe 2> /dev/null
    stl.restore ${MTD_EXE_0_STL} $UPDATE_IMG_DIR/exe.img 2> /dev/null
    if [ $? != 0 ];then
        echo "partition erase & stl format"
        partition.erase ${MTD_EXE_0_BML}
        stl.format -r 2 ${MTD_EXE_0_BML}
        stl.restore ${MTD_EXE_0_STL} $UPDATE_IMG_DIR/exe.img 2> /dev/null
    else
        echo "Already STL formatted!"
    fi


	stl.restore ${MTD_EXE_0_STL} $UPDATE_IMG_DIR/exe.img 2> /dev/null
	sync
    if [ -e $SHELL_UPDATE_FLAG ]
    then
        rm -rf $UPDATE_IMG_DIR/exe.img
		sync
    fi
	echo "END update exe.img"
else
    echo "exe.img is not found."
fi

#if [ -e $UPDATE_IMG_DIR/rocommon.img ]
#then
#	echo ""
#	echo "START update rocommon.img"
#	umount /mtd_rocommon 2> /dev/null
#	dd if=$UPDATE_IMG_DIR/rocommon.img of=${MTD_ROCOMMON}
#	sync
#    if [ -e $SHELL_UPDATE_FLAG ]
#    then
#        rm -rf $UPDATE_IMG_DIR/rocommon.img
#		sync
#    fi
#	echo "END update rocommon.img"
#else
#	echo "Skip update rocommon.img"
#fi

if [ -e $UPDATE_IMG_DIR/rwcommon.img ]; then
	echo ""
	echo "START update rwcommon.img"
	umount /mtd_rwcommon 2> /dev/null
	dd if=$UPDATE_IMG_DIR/rwcommon.img of=${MTD_RWCOMMON}
	sync
    if [ -e $SHELL_UPDATE_FLAG ]
    then
        rm -rf $UPDATE_IMG_DIR/rwcommon.img
		sync
    fi
	echo "END update rwcommon.img"
else
   	echo "rwcommon.img is not found."
fi

if [ -e $UPDATE_IMG_DIR/emanual.img ]; then
    echo ""
    echo "START update emanual.img"
    umount /mtd_emanual 2> /dev/null
    dd if=$UPDATE_IMG_DIR/emanual.img of=${MTD_EMANUAL}
    sync
    if [ -e $SHELL_UPDATE_FLAG ]
    then
        rm -rf $UPDATE_IMG_DIR/emanual.img
		sync
    fi
    echo "END update emanual.img"
else
    echo "emanual.img is not found."
fi

rm -Rf $USB_UPDATE_FLAG
sync
rm -Rf $SHELL_UPDATE_FLAG
sync

$MICOM_BASE/ledoff
echo ""
echo "Reboot system..."
$MICOM_BASE/reboot
sleep 3

