#!/bin/sh

# USB insmod & mount
umount /mtd_exe
/etc/Scripts/usb_start.sh

BOARD_INFO=updateX12

############## Partition Information ##############
export MTD_ONBOOT=/dev/mmcblk0p0
export MTD_UBOOT=/dev/mmcblk0p1
export MTD_NUTX_0=/dev/mmcblk0p2
export MTD_NUTX_1=/dev/mmcblk0p3
export EX_PARTITION=/dev/mmcblk0p4
export MTD_SERET_0=/dev/mmcblk0p5
export MTD_SERET_1=/dev/mmcblk0p6
export MTD_KERNEL_0=/dev/mmcblk0p7
export MTD_ROOTFS_0=/dev/mmcblk0p8
export MTD_KERNEL_1=/dev/mmcblk0p9
export MTD_ROOTFS_1=/dev/mmcblk0p10
export SECUREMAC0=/dev/mmcblk0p11
export SECUREMAC1=/dev/mmcblk0p12
export SECUREMAC2=/dev/mmcblk0p13
export MTD_DRMREGION_A=/dev/mmcblk0p14
export MTD_DRMREGION_B=/dev/mmcblk0p15
export MTD_RWAREA=/dev/mmcblk0p16
export MTD_EXE_0=/dev/mmcblk0p17
export MTD_EXE_1=/dev/mmcblk0p18
export MTD_UNCOMPEXE_0=/dev/mmcblk0p19
export MTD_UNCOMPEXE_1=/dev/mmcblk0p20
export MTD_ROCOMMON_0=/dev/mmcblk0p21
export MTD_ROCOMMON_1=/dev/mmcblk0p22
export MTD_EMANUAL=/dev/mmcblk0p23
export MTD_CONTENTS=/dev/mmcblk0p24
export MTD_SWU=/dev/mmcblk0p25
export MTD_RWCOMMON=/dev/mmcblk0p26

echo "Start usb update"
echo "Do not power off nor remove usb before update is finished"
echo "Please BSP(onboot, u-boot) must be updated in u-boot"
echo -n "Image folder name(enter : "$BOARD_INFO") = "
read directory

if [ "$directory" = "" ]
then
	directory=$BOARD_INFO
fi

PART_FLAG=$(cat /proc/cmdline | cut -d'/' -f3 | cut -d' ' -f1)

if [ "$PART_FLAG" = "mmcblk0p8" ]
then
	partition="1"
	echo "Current partition is $partition."
	partition="2" 
	echo "Update partition is $partition."	
else
	partition="2"
	echo "Current partition is $partition."
	partition="1"
	echo "Update partition is $partition."
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
	echo "$MDIR/$directory does not exist"
	exit 1
fi

echo "updating $MDIR/$directory/"

echo ""

if [ -e  $MDIR/$directory/uImage ]
then
        echo "START update uImage"
        if [ "$partition" = "1" ]
        then
                echo "update 1st partition"
                dd if=$MDIR/$directory/uImage of=${MTD_KERNEL_0} 2> /dev/null

 		if [ $? != 0 ]
                then
                        echo "Partition update retry"
                        dd if=$MDIR/$directory/uImage of=${MTD_KERNEL_0} 2> /dev/null

                        if [ $? != 0 ]
                        then
                              echo "[uImage] Failed to update partition..."
                              exit
                        fi
                fi
        elif [ "$partition" = "2" ]
        then
                echo "update 2nd partition"
        	dd if=$MDIR/$directory/uImage of=${MTD_KERNEL_1} 2> /dev/null
		
		if [ $? != 0 ]
                then
                        echo "Partition update retry"
                        dd if=$MDIR/$directory/uImage of=${MTD_KERNEL_1} 2> /dev/null

                        if [ $? != 0 ]
                        then
                              echo "[uImage] Failed to update partition..."
                              exit
                        fi
                fi
	fi
        sync
        echo "END update uImage"
else
        echo "uImage is not found"
fi

echo ""

if [ -e  $MDIR/$directory/sign0.bin ] && [ "$partition" = "1" ]
then
        echo "START update sign0.bin"
        echo "update 1st partition"
        dd if=$MDIR/$directory/sign0.bin of=${SECUREMAC0} 2> /dev/null

        if [ $? != 0 ]
        then
                echo "Partition update retry"
                dd if=$MDIR/$directory/sign0.bin of=${SECUREMAC0} 2> /dev/null

                if [ $? != 0 ]
                then
                        echo "[sign0.bin] Failed to update partition..."
                        exit
                fi
        fi

        sync
        echo "END update sign0.bin"

elif [ -e  $MDIR/$directory/sign1.bin ] && [ "$partition" = "2" ]
then
        echo "START update sign1.bin"
        echo "update 2nd partition"
        dd if=$MDIR/$directory/sign1.bin of=${SECUREMAC1} 2> /dev/null

        if [ $? != 0 ]
        then
                echo "Partition update retry"
                dd if=$MDIR/$directory/sign1.bin of=${SECUREMAC1} 2> /dev/null
                if [ $? != 0 ]
                then
                        echo "[sign1.bin] Failed to update partition..."
                        exit
                fi
        fi

        sync
        echo "END update sign1.bin"
else
        echo "sign0.bin or sign1.bin is not found"
fi

echo ""

if [ -e  $MDIR/$directory/exe.img ]
then
        echo "START update exe.img"
        if [ "$partition" = "1" ]
        then
		if [ "$(mount | grep ${MTD_EXE_0})" != "" ]
                then
                        umount /mtd_exe
                        if [ $? != 0 ]
                        then
                                echo "mtd_exe umount error"
                        fi
                fi

                echo "update 1st partition"
                dd if=$MDIR/$directory/exe.img of=${MTD_EXE_0} 2> /dev/null
		
	        if [ $? != 0 ]
		then
	                echo "Partition update retry"
			dd if=$MDIR/$directory/exe.img of=${MTD_EXE_0} 2> /dev/null

                        if [ $? != 0 ]
                        then
                              echo "[exe.img] Failed to update partition..."
                              exit
                        fi
		fi	
        elif [ "$partition" = "2" ]
        then
		if [ "$(mount | grep ${MTD_EXE_1})" != "" ]
                then
                        umount /mtd_exe
                        if [ $? != 0 ]
                        then
                                echo "mtd_exe umount error"
                        fi
                fi		

                echo "update 2nd partition"
                dd if=$MDIR/$directory/exe.img of=${MTD_EXE_1} 2> /dev/null
              
		if [ $? != 0 ]
		then
                        echo "Partition update retry"
                        dd if=$MDIR/$directory/exe.img of=${MTD_EXE_1} 2> /dev/null

                        if [ $? != 0 ]
                        then
                              echo "[exe.img] Failed to update partition..."
                              exit
                        fi
                fi
        fi
        sync
        echo "END update exe.img"
else
        echo "exe.img is not found"
fi

echo ""

if [ -e  $MDIR/$directory/uncompexe.img ]
then
        echo "START update uncompexe.img"
        if [ "$partition" = "1" ]
        then
		if [ "$(mount | grep ${MTD_UNCOMPEXE_0})" != "" ]
                then
                        umount /mtd_uncompexe
                        if [ $? != 0 ]
                        then
                                echo "mtd_uncompexe umount error"
                        fi
                fi

                echo "update 1st partition"
                dd if=$MDIR/$directory/uncompexe.img of=${MTD_UNCOMPEXE_0} 2> /dev/null
		
	        if [ $? != 0 ]
		then
	                echo "Partition update retry"
			dd if=$MDIR/$directory/uncompexe.img of=${MTD_UNCOMPEXE_0} 2> /dev/null

                        if [ $? != 0 ]
                        then
                              echo "[uncompexe.img] Failed to update partition..."
                              exit
                        fi
		fi	
        elif [ "$partition" = "2" ]
        then
		if [ "$(mount | grep ${MTD_UNCOMPEXE_1})" != "" ]
                then
                        umount /mtd_uncompexe
                        if [ $? != 0 ]
                        then
                                echo "mtd_uncompexe umount error"
                        fi
                fi		

                echo "update 2nd partition"
                dd if=$MDIR/$directory/uncompexe.img of=${MTD_UNCOMPEXE_1} 2> /dev/null
              
		if [ $? != 0 ]
		then
                        echo "Partition update retry"
                        dd if=$MDIR/$directory/uncompexe.img of=${MTD_UNCOMPEXE_1} 2> /dev/null

                        if [ $? != 0 ]
                        then
                              echo "[uncompexe.img] Failed to update partition..."
                              exit
                        fi
                fi
        fi
        sync
        echo "END update uncompexe.img"
else
        echo "uncompexe.img is not found"
fi

echo ""

if [ -e  $MDIR/$directory/rocommon.img ]
then
        echo "START update rocommon.img"

        if [ "$partition" = "1" ]
        then
	        if [ "$(mount | grep ${MTD_ROCOMMON_0})" != "" ]
	then
		umount /mtd_rocommon
	        if [ $? != 0 ]
	        then
        	        echo "mtd_rocommon umount error"
        	fi
	fi

                echo "update 1st partition"
                dd if=$MDIR/$directory/rocommon.img of=${MTD_ROCOMMON_0} 2> /dev/null

        if [ $? != 0 ]
        then
		echo "Partition update retry"
		        dd if=$MDIR/$directory/rocommon.img of=${MTD_ROCOMMON_0} 2> /dev/null

                        if [ $? != 0 ]
                        then
                              echo "[rocommon.img] Failed to update partition..."
                              exit
                        fi
                fi
        elif [ "$partition" = "2" ]
        then
                if [ "$(mount | grep ${MTD_ROCOMMON_1})" != "" ]
                then
                        umount /mtd_rocommon
                        if [ $? != 0 ]
                        then
                                 echo "mtd_rocommon umount error"
                        fi
        fi

                echo "update 2nd partition"
                dd if=$MDIR/$directory/rocommon.img of=${MTD_ROCOMMON_1} 2> /dev/null

                if [ $? != 0 ]
                then
                        echo "Partition update retry"
                        dd if=$MDIR/$directory/rocommon.img of=${MTD_ROCOMMON_1} 2> /dev/null

                        if [ $? != 0 ]
                        then
                              echo "[rocommon.img] Failed to update partition..."
                              exit
                        fi
                fi
        fi
        sync
        echo "END update rocommon.img"
else
        echo "rocommon.img is not found"
fi

echo ""

if [ -e  $MDIR/$directory/emanual.img ]
then
        echo "START update emanual.img"

        if [ "$(mount | grep ${MTD_EMANUAL})" != "" ]
        then
                umount /mtd_emanual
                if [ $? != 0 ]
                then
                        echo "mtd_emanual umount error"
                fi
        fi

        dd if=$MDIR/$directory/emanual.img of=${MTD_EMANUAL} 2> /dev/null

        if [ $? != 0 ]
        then
			echo "emanual update fail"
			mkfs.emmcfs ${MTD_EMANUAL}
        fi
        sync
        echo "END update emanual.img"
else
        echo "emanual.img is not found"
fi

echo ""

if [ -e  $MDIR/$directory/rwcommon.img ]
then
        echo "START update rwcommon.img"

        if [ "$(mount | grep ${MTD_RWCOMMON})" != "" ]
        then
                umount /mtd_rwcommon
                if [ $? != 0 ]
                then
                        echo "mtd_rwcommon umount error"
                fi
        fi

        dd if=$MDIR/$directory/rwcommon.img of=${MTD_RWCOMMON} 2> /dev/null

        if [ $? != 0 ]
        then
			echo "rwcommon update fail"
			mkfs.emmcfs ${MTD_RWCOMMON}
        fi
        sync
        echo "END update rwcommon.img"
else
        echo "rwcommon.img is not found"
fi

echo ""

if [ -e  $MDIR/$directory/rootfs.img ]
then
        echo "START update rootfs.img"
        if [ "$partition" = "1" ]
        then
                echo "update 1st partition"
                dd if=$MDIR/$directory/rootfs.img of=${MTD_ROOTFS_0} 2> /dev/null

                if [ $? != 0 ]
                then
                        echo "Partition update retry"
                        dd if=$MDIR/$directory/rootfs.img of=${MTD_ROOTFS_0} 2> /dev/null

                        if [ $? != 0 ]
                        then
                              echo "[rootfs.img] Failed to update partition..."
                              exit
                        fi
                fi
        elif [ "$partition" = "2" ]
        then
                echo "update 2nd partition"
                dd if=$MDIR/$directory/rootfs.img of=${MTD_ROOTFS_1} 2> /dev/null

                if [ $? != 0 ]
                then
                        echo "Partition update retry"
                        dd if=$MDIR/$directory/rootfs.img of=${MTD_ROOTFS_1} 2> /dev/null

                        if [ $? != 0 ]
                        then
                              echo "[rootfs.img] Failed to update partition..."
                              exit
                        fi
                fi
        fi
        sync
        echo "END update rootfs.img"
else
        echo "rootfs.img is not found"
fi

echo ""

if [ -e  $MDIR/$directory/secos.bin ]
then
	echo "START update secos.bin"
	if [ "$partition" = "1" ]
	then
		echo "update 1st partition"
		dd if=$MDIR/$directory/secos.bin of=${MTD_NUTX_0} 2> /dev/null

		if [ $? != 0 ]
		then
			echo "Partition update retry"
			dd if=$MDIR/$directory/secos.bin of=${MTD_NUTX_0} 2> /dev/null

                        if [ $? != 0 ]
                        then
                              echo "[secos.bin] Failed to update partition..."
                              exit
                        fi
		fi
	elif [ "$partition" = "2" ]
	then
		echo "update 2nd partition"
		dd if=$MDIR/$directory/secos.bin of=${MTD_NUTX_1} 2> /dev/null

		if [ $? != 0 ]
		then
			echo "Partition update retry"
			dd if=$MDIR/$directory/secos.bin of=${MTD_NUTX_1} 2> /dev/null

                        if [ $? != 0 ]
                        then
                              echo "[secos.bin] Failed to update partition..."
                              exit
                        fi
		fi
	fi
	sync
	echo "END update secos.bin"
else
		echo "secos.bin is not found"
fi

echo ""

if [ -e  $MDIR/$directory/seret.bin ]
then
	echo "START update seret.bin"
	if [ "$partition" = "1" ]
	then
		echo "update 1st partition"
		dd if=$MDIR/$directory/seret.bin of=${MTD_SERET_0} 2> /dev/null

		if [ $? != 0 ]
		then
			echo "Partition update retry"
			dd if=$MDIR/$directory/seret.bin of=${MTD_SERET_0} 2> /dev/null

                        if [ $? != 0 ]
                        then
                              echo "[seret.bin] Failed to update partition..."
                              exit
                        fi
		fi
	elif [ "$partition" = "2" ]
	then
		echo "update 2nd partition"
		dd if=$MDIR/$directory/seret.bin of=${MTD_SERET_1} 2> /dev/null

		if [ $? != 0 ]
		then
			echo "Partition update retry"
			dd if=$MDIR/$directory/seret.bin of=${MTD_SERET_1} 2> /dev/null

                        if [ $? != 0 ]
                        then
                              echo "[seret.bin] Failed to update partition..."
                              exit
                        fi
		fi
	fi
	sync
	echo "END update seret.bin"
else
		echo "seret.bin is not found"
fi

echo ""

if [ "$partition" = "2" ]
then
        echo ""
        echo "toggle to 2nd partition"
        $MICOM_BASE/micom toggle 1
        echo ""
elif [ "$partition" = "1" ]
then
        echo ""
        echo "toggle to 1st partition"
        $MICOM_BASE/micom toggle 0
        echo ""
fi

echo ""
echo "Update End"
echo "Reboot System"
$MICOM_BASE/micom reboot
sleep 3
#!/bin/sh

# USB insmod & mount
umount /mtd_exe
/etc/Scripts/usb_start.sh

BOARD_INFO=updateX12

############## Partition Information ##############
export MTD_ONBOOT=/dev/mmcblk0p0
export MTD_UBOOT=/dev/mmcblk0p1
export MTD_NUTX_0=/dev/mmcblk0p2
export MTD_NUTX_1=/dev/mmcblk0p3
export EX_PARTITION=/dev/mmcblk0p4
export MTD_SERET_0=/dev/mmcblk0p5
export MTD_SERET_1=/dev/mmcblk0p6
export MTD_KERNEL_0=/dev/mmcblk0p7
export MTD_ROOTFS_0=/dev/mmcblk0p8
export MTD_KERNEL_1=/dev/mmcblk0p9
export MTD_ROOTFS_1=/dev/mmcblk0p10
export SECUREMAC0=/dev/mmcblk0p11
export SECUREMAC1=/dev/mmcblk0p12
export SECUREMAC2=/dev/mmcblk0p13
export MTD_DRMREGION_A=/dev/mmcblk0p14
export MTD_DRMREGION_B=/dev/mmcblk0p15
export MTD_RWAREA=/dev/mmcblk0p16
export MTD_EXE_0=/dev/mmcblk0p17
export MTD_EXE_1=/dev/mmcblk0p18
export MTD_UNCOMPEXE_0=/dev/mmcblk0p19
export MTD_UNCOMPEXE_1=/dev/mmcblk0p20
export MTD_ROCOMMON_0=/dev/mmcblk0p21
export MTD_ROCOMMON_1=/dev/mmcblk0p22
export MTD_EMANUAL=/dev/mmcblk0p23
export MTD_CONTENTS=/dev/mmcblk0p24
export MTD_SWU=/dev/mmcblk0p25
export MTD_RWCOMMON=/dev/mmcblk0p26

echo "Start usb update"
echo "Do not power off nor remove usb before update is finished"
echo "Please BSP(onboot, u-boot) must be updated in u-boot"
echo -n "Image folder name(enter : "$BOARD_INFO") = "
read directory

if [ "$directory" = "" ]
then
	directory=$BOARD_INFO
fi

PART_FLAG=$(cat /proc/cmdline | cut -d'/' -f3 | cut -d' ' -f1)

if [ "$PART_FLAG" = "mmcblk0p8" ]
then
	partition="1"
	echo "Current partition is $partition."
	partition="2" 
	echo "Update partition is $partition."	
else
	partition="2"
	echo "Current partition is $partition."
	partition="1"
	echo "Update partition is $partition."
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
	echo "$MDIR/$directory does not exist"
	exit 1
fi

echo "updating $MDIR/$directory/"

echo ""

if [ -e  $MDIR/$directory/uImage ]
then
        echo "START update uImage"
        if [ "$partition" = "1" ]
        then
                echo "update 1st partition"
                dd if=$MDIR/$directory/uImage of=${MTD_KERNEL_0} 2> /dev/null

 		if [ $? != 0 ]
                then
                        echo "Partition update retry"
                        dd if=$MDIR/$directory/uImage of=${MTD_KERNEL_0} 2> /dev/null

                        if [ $? != 0 ]
                        then
                              echo "[uImage] Failed to update partition..."
                              exit
                        fi
                fi
        elif [ "$partition" = "2" ]
        then
                echo "update 2nd partition"
        	dd if=$MDIR/$directory/uImage of=${MTD_KERNEL_1} 2> /dev/null
		
		if [ $? != 0 ]
                then
                        echo "Partition update retry"
                        dd if=$MDIR/$directory/uImage of=${MTD_KERNEL_1} 2> /dev/null

                        if [ $? != 0 ]
                        then
                              echo "[uImage] Failed to update partition..."
                              exit
                        fi
                fi
	fi
        sync
        echo "END update uImage"
else
        echo "uImage is not found"
fi

echo ""

if [ -e  $MDIR/$directory/sign0.bin ] && [ "$partition" = "1" ]
then
        echo "START update sign0.bin"
        echo "update 1st partition"
        dd if=$MDIR/$directory/sign0.bin of=${SECUREMAC0} 2> /dev/null

        if [ $? != 0 ]
        then
                echo "Partition update retry"
                dd if=$MDIR/$directory/sign0.bin of=${SECUREMAC0} 2> /dev/null

                if [ $? != 0 ]
                then
                        echo "[sign0.bin] Failed to update partition..."
                        exit
                fi
        fi

        sync
        echo "END update sign0.bin"

elif [ -e  $MDIR/$directory/sign1.bin ] && [ "$partition" = "2" ]
then
        echo "START update sign1.bin"
        echo "update 2nd partition"
        dd if=$MDIR/$directory/sign1.bin of=${SECUREMAC1} 2> /dev/null

        if [ $? != 0 ]
        then
                echo "Partition update retry"
                dd if=$MDIR/$directory/sign1.bin of=${SECUREMAC1} 2> /dev/null
                if [ $? != 0 ]
                then
                        echo "[sign1.bin] Failed to update partition..."
                        exit
                fi
        fi

        sync
        echo "END update sign1.bin"
else
        echo "sign0.bin or sign1.bin is not found"
fi

echo ""

if [ -e  $MDIR/$directory/exe.img ]
then
        echo "START update exe.img"
        if [ "$partition" = "1" ]
        then
		if [ "$(mount | grep ${MTD_EXE_0})" != "" ]
                then
                        umount /mtd_exe
                        if [ $? != 0 ]
                        then
                                echo "mtd_exe umount error"
                        fi
                fi

                echo "update 1st partition"
                dd if=$MDIR/$directory/exe.img of=${MTD_EXE_0} 2> /dev/null
		
	        if [ $? != 0 ]
		then
	                echo "Partition update retry"
			dd if=$MDIR/$directory/exe.img of=${MTD_EXE_0} 2> /dev/null

                        if [ $? != 0 ]
                        then
                              echo "[exe.img] Failed to update partition..."
                              exit
                        fi
		fi	
        elif [ "$partition" = "2" ]
        then
		if [ "$(mount | grep ${MTD_EXE_1})" != "" ]
                then
                        umount /mtd_exe
                        if [ $? != 0 ]
                        then
                                echo "mtd_exe umount error"
                        fi
                fi		

                echo "update 2nd partition"
                dd if=$MDIR/$directory/exe.img of=${MTD_EXE_1} 2> /dev/null
              
		if [ $? != 0 ]
		then
                        echo "Partition update retry"
                        dd if=$MDIR/$directory/exe.img of=${MTD_EXE_1} 2> /dev/null

                        if [ $? != 0 ]
                        then
                              echo "[exe.img] Failed to update partition..."
                              exit
                        fi
                fi
        fi
        sync
        echo "END update exe.img"
else
        echo "exe.img is not found"
fi

echo ""

if [ -e  $MDIR/$directory/uncompexe.img ]
then
        echo "START update uncompexe.img"
        if [ "$partition" = "1" ]
        then
		if [ "$(mount | grep ${MTD_UNCOMPEXE_0})" != "" ]
                then
                        umount /mtd_uncompexe
                        if [ $? != 0 ]
                        then
                                echo "mtd_uncompexe umount error"
                        fi
                fi

                echo "update 1st partition"
                dd if=$MDIR/$directory/uncompexe.img of=${MTD_UNCOMPEXE_0} 2> /dev/null
		
	        if [ $? != 0 ]
		then
	                echo "Partition update retry"
			dd if=$MDIR/$directory/uncompexe.img of=${MTD_UNCOMPEXE_0} 2> /dev/null

                        if [ $? != 0 ]
                        then
                              echo "[uncompexe.img] Failed to update partition..."
                              exit
                        fi
		fi	
        elif [ "$partition" = "2" ]
        then
		if [ "$(mount | grep ${MTD_UNCOMPEXE_1})" != "" ]
                then
                        umount /mtd_uncompexe
                        if [ $? != 0 ]
                        then
                                echo "mtd_uncompexe umount error"
                        fi
                fi		

                echo "update 2nd partition"
                dd if=$MDIR/$directory/uncompexe.img of=${MTD_UNCOMPEXE_1} 2> /dev/null
              
		if [ $? != 0 ]
		then
                        echo "Partition update retry"
                        dd if=$MDIR/$directory/uncompexe.img of=${MTD_UNCOMPEXE_1} 2> /dev/null

                        if [ $? != 0 ]
                        then
                              echo "[uncompexe.img] Failed to update partition..."
                              exit
                        fi
                fi
        fi
        sync
        echo "END update uncompexe.img"
else
        echo "uncompexe.img is not found"
fi

echo ""

if [ -e  $MDIR/$directory/rocommon.img ]
then
        echo "START update rocommon.img"

        if [ "$partition" = "1" ]
        then
	        if [ "$(mount | grep ${MTD_ROCOMMON_0})" != "" ]
	then
		umount /mtd_rocommon
	        if [ $? != 0 ]
	        then
        	        echo "mtd_rocommon umount error"
        	fi
	fi

                echo "update 1st partition"
                dd if=$MDIR/$directory/rocommon.img of=${MTD_ROCOMMON_0} 2> /dev/null

        if [ $? != 0 ]
        then
		echo "Partition update retry"
		        dd if=$MDIR/$directory/rocommon.img of=${MTD_ROCOMMON_0} 2> /dev/null

                        if [ $? != 0 ]
                        then
                              echo "[rocommon.img] Failed to update partition..."
                              exit
                        fi
                fi
        elif [ "$partition" = "2" ]
        then
                if [ "$(mount | grep ${MTD_ROCOMMON_1})" != "" ]
                then
                        umount /mtd_rocommon
                        if [ $? != 0 ]
                        then
                                 echo "mtd_rocommon umount error"
                        fi
        fi

                echo "update 2nd partition"
                dd if=$MDIR/$directory/rocommon.img of=${MTD_ROCOMMON_1} 2> /dev/null

                if [ $? != 0 ]
                then
                        echo "Partition update retry"
                        dd if=$MDIR/$directory/rocommon.img of=${MTD_ROCOMMON_1} 2> /dev/null

                        if [ $? != 0 ]
                        then
                              echo "[rocommon.img] Failed to update partition..."
                              exit
                        fi
                fi
        fi
        sync
        echo "END update rocommon.img"
else
        echo "rocommon.img is not found"
fi

echo ""

if [ -e  $MDIR/$directory/emanual.img ]
then
        echo "START update emanual.img"

        if [ "$(mount | grep ${MTD_EMANUAL})" != "" ]
        then
                umount /mtd_emanual
                if [ $? != 0 ]
                then
                        echo "mtd_emanual umount error"
                fi
        fi

        dd if=$MDIR/$directory/emanual.img of=${MTD_EMANUAL} 2> /dev/null

        if [ $? != 0 ]
        then
			echo "emanual update fail"
			mkfs.emmcfs ${MTD_EMANUAL}
        fi
        sync
        echo "END update emanual.img"
else
        echo "emanual.img is not found"
fi

echo ""

if [ -e  $MDIR/$directory/rwcommon.img ]
then
        echo "START update rwcommon.img"

        if [ "$(mount | grep ${MTD_RWCOMMON})" != "" ]
        then
                umount /mtd_rwcommon
                if [ $? != 0 ]
                then
                        echo "mtd_rwcommon umount error"
                fi
        fi

        dd if=$MDIR/$directory/rwcommon.img of=${MTD_RWCOMMON} 2> /dev/null

        if [ $? != 0 ]
        then
			echo "rwcommon update fail"
			mkfs.emmcfs ${MTD_RWCOMMON}
        fi
        sync
        echo "END update rwcommon.img"
else
        echo "rwcommon.img is not found"
fi

echo ""

if [ -e  $MDIR/$directory/rootfs.img ]
then
        echo "START update rootfs.img"
        if [ "$partition" = "1" ]
        then
                echo "update 1st partition"
                dd if=$MDIR/$directory/rootfs.img of=${MTD_ROOTFS_0} 2> /dev/null

                if [ $? != 0 ]
                then
                        echo "Partition update retry"
                        dd if=$MDIR/$directory/rootfs.img of=${MTD_ROOTFS_0} 2> /dev/null

                        if [ $? != 0 ]
                        then
                              echo "[rootfs.img] Failed to update partition..."
                              exit
                        fi
                fi
        elif [ "$partition" = "2" ]
        then
                echo "update 2nd partition"
                dd if=$MDIR/$directory/rootfs.img of=${MTD_ROOTFS_1} 2> /dev/null

                if [ $? != 0 ]
                then
                        echo "Partition update retry"
                        dd if=$MDIR/$directory/rootfs.img of=${MTD_ROOTFS_1} 2> /dev/null

                        if [ $? != 0 ]
                        then
                              echo "[rootfs.img] Failed to update partition..."
                              exit
                        fi
                fi
        fi
        sync
        echo "END update rootfs.img"
else
        echo "rootfs.img is not found"
fi

echo ""

if [ -e  $MDIR/$directory/secos.bin ]
then
	echo "START update secos.bin"
	if [ "$partition" = "1" ]
	then
		echo "update 1st partition"
		dd if=$MDIR/$directory/secos.bin of=${MTD_NUTX_0} 2> /dev/null

		if [ $? != 0 ]
		then
			echo "Partition update retry"
			dd if=$MDIR/$directory/secos.bin of=${MTD_NUTX_0} 2> /dev/null

                        if [ $? != 0 ]
                        then
                              echo "[secos.bin] Failed to update partition..."
                              exit
                        fi
		fi
	elif [ "$partition" = "2" ]
	then
		echo "update 2nd partition"
		dd if=$MDIR/$directory/secos.bin of=${MTD_NUTX_1} 2> /dev/null

		if [ $? != 0 ]
		then
			echo "Partition update retry"
			dd if=$MDIR/$directory/secos.bin of=${MTD_NUTX_1} 2> /dev/null

                        if [ $? != 0 ]
                        then
                              echo "[secos.bin] Failed to update partition..."
                              exit
                        fi
		fi
	fi
	sync
	echo "END update secos.bin"
else
		echo "secos.bin is not found"
fi

echo ""

if [ -e  $MDIR/$directory/seret.bin ]
then
	echo "START update seret.bin"
	if [ "$partition" = "1" ]
	then
		echo "update 1st partition"
		dd if=$MDIR/$directory/seret.bin of=${MTD_SERET_0} 2> /dev/null

		if [ $? != 0 ]
		then
			echo "Partition update retry"
			dd if=$MDIR/$directory/seret.bin of=${MTD_SERET_0} 2> /dev/null

                        if [ $? != 0 ]
                        then
                              echo "[seret.bin] Failed to update partition..."
                              exit
                        fi
		fi
	elif [ "$partition" = "2" ]
	then
		echo "update 2nd partition"
		dd if=$MDIR/$directory/seret.bin of=${MTD_SERET_1} 2> /dev/null

		if [ $? != 0 ]
		then
			echo "Partition update retry"
			dd if=$MDIR/$directory/seret.bin of=${MTD_SERET_1} 2> /dev/null

                        if [ $? != 0 ]
                        then
                              echo "[seret.bin] Failed to update partition..."
                              exit
                        fi
		fi
	fi
	sync
	echo "END update seret.bin"
else
		echo "seret.bin is not found"
fi

echo ""

if [ "$partition" = "2" ]
then
        echo ""
        echo "toggle to 2nd partition"
        $MICOM_BASE/micom toggle 1
        echo ""
elif [ "$partition" = "1" ]
then
        echo ""
        echo "toggle to 1st partition"
        $MICOM_BASE/micom toggle 0
        echo ""
fi

echo ""
echo "Update End"
echo "Reboot System"
$MICOM_BASE/micom reboot
sleep 3
