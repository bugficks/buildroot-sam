#!/bin/sh

echo "/etc/Scripts/partition_check.sh start!!!!"

export TARGET_MTD_ONBOOT=0
export TARGET_MTD_UBOOT=0
export TARGET_MTD_KERNEL_0=0
export TARGET_MTD_ROOTFS_0=0
export TARGET_EX_PARTITION=0
export TARGET_MTD_KERNEL_1=0
export TARGET_MTD_ROOTFS_1=0
export TARGET_SECUREMAC0=0
export TARGET_SECUREMAC1=0
export TARGET_SECUREMAC2=0
export TARGET_MTD_DRMREGION_A=0
export TARGET_MTD_DRMREGION_B=0
export TARGET_MTD_RWAREA=0
export TARGET_MTD_EXE_0=0
export TARGET_MTD_EXE_1=0
export TARGET_MTD_ROCOMMON=0
export TARGET_MTD_EMANUAL=0
export TARGET_MTD_CONTENTS=0
export TARGET_MTD_SWU=0
export TARGET_MTD_RWCOMMON=0

export EXE_MTD_ONBOOT=0
export EXE_MTD_UBOOT=0
export EXE_MTD_KERNEL_0=0
export EXE_MTD_ROOTFS_0=0
export EXE_EX_PARTITION=0
export EXE_MTD_KERNEL_1=0
export EXE_MTD_ROOTFS_1=0
export EXE_SECUREMAC0=0
export EXE_SECUREMAC1=0
export EXE_SECUREMAC2=0
export EXE_MTD_DRMREGION_A=0
export EXE_MTD_DRMREGION_B=0
export EXE_MTD_RWAREA=0
export EXE_MTD_EXE_0=0
export EXE_MTD_EXE_1=0
export EXE_MTD_ROCOMMON=0
export EXE_MTD_EMANUAL=0
export EXE_MTD_CONTENTS=0
export EXE_MTD_SWU=0
export EXE_MTD_RWCOMMON=0

export USB_PATH=NULL
export TARGET_PATH=NULL

PARTITION_CHANGE_EMMC_BSP=0
PARTITION_CHANGE_EMMC_APP=0
################################################

USB_PATH=$(awk '/MountDir/ {print $3}' /dtv/usb/usblog)
TARGET_PATH=$(awk '{print $1}' /mtd_exe/.info)

#echo "umount mtd_exe"
#umount /mtd_exe/

echo "target partition..."
cat /proc/partitions > /tmp/target.txt

echo "exe partition..."

cp -ar $USB_PATH/$TARGET_PATH/image/partition.txt /tmp/exe.txt

echo "target.txt..."
TARGET_MTD_ONBOOT=$(awk '{if($4=="mmcblk0") print $3}' /tmp/target.txt)
TARGET_MTD_UBOOT=$(awk '{if($4=="mmcblk0p1") print $3}' /tmp/target.txt)
TARGET_MTD_KERNEL_0=$(awk '{if($4=="mmcblk0p2") print $3}' /tmp/target.txt)
TARGET_MTD_ROOTFS_0=$(awk '{if($4=="mmcblk0p3") print $3}' /tmp/target.txt)
TARGET_EX_PARTITION=$(awk '{if($4=="mmcblk0p4") print $3}' /tmp/target.txt)
TARGET_MTD_KERNEL_1=$(awk '{if($4=="mmcblk0p5") print $3}' /tmp/target.txt)
TARGET_MTD_ROOTFS_1=$(awk '{if($4=="mmcblk0p6") print $3}' /tmp/target.txt)
TARGET_SECUREMAC0=$(awk '{if($4=="mmcblk0p7") print $3}' /tmp/target.txt)
TARGET_SECUREMAC1=$(awk '{if($4=="mmcblk0p8") print $3}' /tmp/target.txt)
TARGET_SECUREMAC2=$(awk '{if($4=="mmcblk0p9") print $3}' /tmp/target.txt)
TARGET_MTD_DRMREGION_A=$(awk '{if($4=="mmcblk0p10") print $3}' /tmp/target.txt)
TARGET_MTD_DRMREGION_B=$(awk '{if($4=="mmcblk0p11") print $3}' /tmp/target.txt)
TARGET_MTD_RWAREA=$(awk '{if($4=="mmcblk0p12") print $3}' /tmp/target.txt)
TARGET_MTD_EXE_0=$(awk '{if($4=="mmcblk0p13") print $3}' /tmp/target.txt)
TARGET_MTD_EXE_1=$(awk '{if($4=="mmcblk0p14") print $3}' /tmp/target.txt)
TARGET_MTD_ROCOMMON=$(awk '{if($4=="mmcblk0p15") print $3}' /tmp/target.txt)
TARGET_MTD_EMANUAL=$(awk '{if($4=="mmcblk0p16") print $3}' /tmp/target.txt)
TARGET_MTD_CONTENTS=$(awk '{if($4=="mmcblk0p17") print $3}' /tmp/target.txt)
TARGET_MTD_SWU=$(awk '{if($4=="mmcblk0p18") print $3}' /tmp/target.txt)
TARGET_MTD_RWCOMMON=$(awk '{if($4=="mmcblk0p19") print $3}' /tmp/target.txt)

#TARGET_MTD_ONBOOT=`expr $TARGET_MTD_ONBOOT \* 128`
#TARGET_MTD_UBOOT=`expr $TARGET_MTD_UBOOT \* 1024`
#TARGET_MTD_KERNEL_0=`expr $TARGET_MTD_KERNEL_0 \* 1024`
#TARGET_MTD_ROOTFS_0=`expr $TARGET_MTD_ROOTFS_0 \* 1024`
#TARGET_EX_PARTITION=`expr $TARGET_EX_PARTITION \* 1024`
#TARGET_MTD_KERNEL_1=`expr $TARGET_MTD_KERNEL_1 \* 1024`
#TARGET_MTD_ROOTFS_1=`expr $TARGET_MTD_ROOTFS_1 \* 1024`
#TARGET_SECUREMAC0=`expr $TARGET_SECUREMAC0 \* 1024`
#TARGET_SECUREMAC1=`expr $TARGET_SECUREMAC1 \* 1024`
#TARGET_SECUREMAC2=`expr $TARGET_SECUREMAC2 \* 1024`
#TARGET_MTD_DRMREGION_A=`expr $TARGET_MTD_DRMREGION_A \* 1024`
#TARGET_MTD_DRMREGION_B=`expr $TARGET_MTD_DRMREGION_B \* 1024`
#TARGET_MTD_RWAREA=`expr $TARGET_MTD_RWAREA \* 1024`
#TARGET_MTD_EXE_0=`expr $TARGET_MTD_EXE_0 \* 1024`
#TARGET_MTD_EXE_1=`expr $TARGET_MTD_EXE_1 \* 1024`
#TARGET_MTD_APP_0=`expr $TARGET_MTD_APP_0 \* 1024`
#TARGET_MTD_APP_1=`expr $TARGET_MTD_APP_1 \* 1024`
#TARGET_MTD_ROCOMMON=`expr $TARGET_MTD_ROCOMMON \* 1024`
#TARGET_MTD_EMANUAL=`expr $TARGET_MTD_EMANUAL \* 1024`
#TARGET_MTD_CONTENTS=`expr $TARGET_MTD_CONTENTS \* 1024`
#TARGET_MTD_SWU=`expr $TARGET_MTD_SWU \* 1024`
#TARGET_MTD_RWCOMMON=`expr $TARGET_MTD_RWCOMMON \* 1024`

echo "======================= TARGET =============================="
echo ""
#echo "TARGET_MTD_ONBOOT		: $TARGET_MTD_ONBOOT"
echo "TARGET_MTD_UBOOT		: $TARGET_MTD_UBOOT"
echo "TARGET_MTD_KERNEL_0	: $TARGET_MTD_KERNEL_0"
echo "TARGET_MTD_ROOTFS_0	: $TARGET_MTD_ROOTFS_0"
echo "TARGET_EX_PARTITION	: $TARGET_EX_PARTITION"
echo "TARGET_MTD_KERNEL_1	: $TARGET_MTD_KERNEL_1"
echo "TARGET_MTD_ROOTFS_1	: $TARGET_MTD_ROOTFS_1"
echo "TARGET_SECUREMAC0 	: $TARGET_SECUREMAC0"
echo "TARGET_SECUREMAC1 	: $TARGET_SECUREMAC1"
echo "TARGET_SECUREMAC2		: $TARGET_SECUREMAC2"
echo "TARGET_MTD_DRMREGION_A 	: $TARGET_MTD_DRMREGION_A"
echo "TARGET_MTD_DRMREGION_B	: $TARGET_MTD_DRMREGION_B"
echo "TARGET_MTD_RWAREA 	: $TARGET_MTD_RWAREA"
echo "TARGET_MTD_EXE_0	 	: $TARGET_MTD_EXE_0"
echo "TARGET_MTD_EXE_1	 	: $TARGET_MTD_EXE_1"
echo "TARGET_MTD_ROCOMMON 	: $TARGET_MTD_ROCOMMON"
echo "TARGET_MTD_EMANUAL 	: $TARGET_MTD_EMANUAL"
echo "TARGET_MTD_CONTENTS       : $TARGET_MTD_CONTENTS"
echo "TARGET_MTD_SWU    	: $TARGET_MTD_SWU"
echo "TARGET_MTD_RWCOMMON       : $TARGET_MTD_RWCOMMON"
echo ""
echo "============================================================"

echo "exe.txt..."

#EXE_MTD_ONBOOT=$(awk '{if($2=="/dev/mmcblk0p0") print $3}' /tmp/exe.txt)
EXE_MTD_UBOOT=$(awk '{if($2=="/dev/mmcblk0p1") print $3}' /tmp/exe.txt)
EXE_MTD_KERNEL_0=$(awk '{if($2=="/dev/mmcblk0p2") print $3}' /tmp/exe.txt)
EXE_MTD_ROOTFS_0=$(awk '{if($2=="/dev/mmcblk0p3") print $3}' /tmp/exe.txt)
EXE_EX_PARTITION=$(awk '{if($2=="/dev/mmcblk0p4") print $3}' /tmp/exe.txt)
EXE_MTD_KERNEL_1=$(awk '{if($2=="/dev/mmcblk0p5") print $3}' /tmp/exe.txt)
EXE_MTD_ROOTFS_1=$(awk '{if($2=="/dev/mmcblk0p6") print $3}' /tmp/exe.txt)
EXE_SECUREMAC0=$(awk '{if($2=="/dev/mmcblk0p7") print $3}' /tmp/exe.txt)
EXE_SECUREMAC1=$(awk '{if($2=="/dev/mmcblk0p8") print $3}' /tmp/exe.txt)
EXE_SECUREMAC2=$(awk '{if($2=="/dev/mmcblk0p9") print $3}' /tmp/exe.txt)
EXE_MTD_DRMREGION_A=$(awk '{if($2=="/dev/mmcblk0p10") print $3}' /tmp/exe.txt)
EXE_MTD_DRMREGION_B=$(awk '{if($2=="/dev/mmcblk0p11") print $3}' /tmp/exe.txt)
EXE_MTD_RWAREA=$(awk '{if($2=="/dev/mmcblk0p12") print $3}' /tmp/exe.txt)
EXE_MTD_EXE_0=$(awk '{if($2=="/dev/mmcblk0p13") print $3}' /tmp/exe.txt)
EXE_MTD_EXE_1=$(awk '{if($2=="/dev/mmcblk0p14") print $3}' /tmp/exe.txt)
EXE_MTD_ROCOMMON=$(awk '{if($2=="/dev/mmcblk0p15") print $3}' /tmp/exe.txt)
EXE_MTD_EMANUAL=$(awk '{if($2=="/dev/mmcblk0p16") print $3}' /tmp/exe.txt)
EXE_MTD_CONTENTS=$(awk '{if($2=="/dev/mmcblk0p17") print $3}' /tmp/exe.txt)
EXE_MTD_SWU=$(awk '{if($2=="/dev/mmcblk0p18") print $3}' /tmp/exe.txt)
EXE_MTD_RWCOMMON=$(awk '{if($2=="/dev/mmcblk0p19") print $3}' /tmp/exe.txt)

#EXE_MTD_ONBOOT=`expr $EXE_MTD_ONBOOT \* 128`
EXE_MTD_UBOOT=`expr $EXE_MTD_UBOOT \/ 1024`
EXE_MTD_KERNEL_0=`expr $EXE_MTD_KERNEL_0 \/ 1024`
EXE_MTD_ROOTFS_0=`expr $EXE_MTD_ROOTFS_0 \/ 1024`
EXE_EX_PARTITION=`expr $EXE_EX_PARTITION \/ 1024`
EXE_MTD_KERNEL_1=`expr $EXE_MTD_KERNEL_1 \/ 1024`
EXE_MTD_ROOTFS_1=`expr $EXE_MTD_ROOTFS_1 \/ 1024`
EXE_SECUREMAC0=`expr $EXE_SECUREMAC0 \/ 1024`
EXE_SECUREMAC1=`expr $EXE_SECUREMAC1 \/ 1024`
EXE_SECUREMAC2=`expr $EXE_SECUREMAC2 \/ 1024`
EXE_MTD_DRMREGION_A=`expr $EXE_MTD_DRMREGION_A \/ 1024`
EXE_MTD_DRMREGION_B=`expr $EXE_MTD_DRMREGION_B \/ 1024`
EXE_MTD_RWAREA=`expr $EXE_MTD_RWAREA \/ 1024`
EXE_MTD_EXE_0=`expr $EXE_MTD_EXE_0 \/ 1024`
EXE_MTD_EXE_1=`expr $EXE_MTD_EXE_1 \/ 1024`
EXE_MTD_ROCOMMON=`expr $EXE_MTD_ROCOMMON \/ 1024`
EXE_MTD_EMANUAL=`expr $EXE_MTD_EMANUAL \/ 1024`
EXE_MTD_CONTENTS=`expr $EXE_MTD_CONTENTS \/ 1024`
EXE_MTD_SWU=`expr $EXE_MTD_SWU \/ 1024`
EXE_MTD_RWCOMMON=`expr $EXE_MTD_RWCOMMON`

echo "======================= EXE =============================="
echo ""
#echo "EXE_MTD_ONBOOT	   	: $EXE_MTD_ONBOOT"
echo "EXE_MTD_UBOOT           	: $EXE_MTD_UBOOT"
echo "EXE_MTD_KERNEL_0        	: $EXE_MTD_KERNEL_0"
echo "EXE_MTD_ROOTFS_0        	: $EXE_MTD_ROOTFS_0"
echo "EXE_EX_PARTITION         	: $EXE_EX_PARTITION"
echo "EXE_MTD_KERNEL_1         	: $EXE_MTD_KERNEL_1"
echo "EXE_MTD_ROOTFS_1		: $EXE_MTD_ROOTFS_1"
echo "EXE_SECUREMAC0           	: $EXE_SECUREMAC0"
echo "EXE_SECUREMAC1           	: $EXE_SECUREMAC1"
echo "EXE_SECUREMAC2           	: $EXE_SECUREMAC2"
echo "EXE_MTD_DRMREGION_A      	: $EXE_MTD_DRMREGION_A"
echo "EXE_MTD_DRMREGION_B     	: $EXE_MTD_DRMREGION_B"
echo "EXE_MTD_RWAREA           	: $EXE_MTD_RWAREA"
echo "EXE_MTD_EXE_0            	: $EXE_MTD_EXE_0"
echo "EXE_MTD_EXE_1       	: $EXE_MTD_EXE_1"
echo "EXE_MTD_ROCOMMON        	: $EXE_MTD_ROCOMMON"
echo "EXE_MTD_EMANUAL        	: $EXE_MTD_EMANUAL"
echo "EXE_MTD_CONTENTS       	: $EXE_MTD_CONTENTS"
echo "EXE_MTD_SWU       	: $EXE_MTD_SWU"
echo "EXE_MTD_RWCOMMON       	: $EXE_MTD_RWCOMMON"
echo ""
echo "============================================================"
echo "Compare target vs exe partition..."
echo "=========================================="
echo " "

#if [ $EXE_MTD_ONBOOT != $TARGET_MTD_ONBOOT ]
#then
#	echo "MTD_ONBOOT : $TARGET_MTD_ONBOOT ==> $EXE_MTD_ONBOOT"
#	PARTITION_CHANGE_EMMC_BSP=1
#fi

if [ $EXE_MTD_UBOOT != $TARGET_MTD_UBOOT ]
then
    echo "MTD_UBOOT : $TARGET_MTD_UBOOT ==> $EXE_MTD_UBOOT"
	PARTITION_CHANGE_EMMC_BSP=1
fi

if [ $EXE_MTD_KERNEL_0 != $TARGET_MTD_KERNEL_0 ]
then
    echo "MTD_KERNEL_0 : $TARGET_MTD_KERNEL_0 ==> $EXE_MTD_KERNEL_0"
	PARTITION_CHANGE_EMMC_BSP=1
fi

if [ $EXE_MTD_ROOTFS_0 != $TARGET_MTD_ROOTFS_0 ]
then
    echo "MTD_ROOTFS_0 : $TARGET_MTD_ROOTFS_0 ==> $EXE_MTD_ROOTFS_0"
	PARTITION_CHANGE_EMMC_BSP=1
fi

if [ $EXE_EX_PARTITION != $TARGET_EX_PARTITION ]
then
    echo "EX_PARTITION : $TARGET_EX_PARTITION ==> $EXE_EX_PARTITION"
	PARTITION_CHANGE_EMMC_BSP=1
fi

if [ $EXE_MTD_KERNEL_1 != $TARGET_MTD_KERNEL_1 ]
then
    echo "MTD_KERNEL_1 : $TARGET_MTD_KERNEL_1 ==> $EXE_MTD_KERNEL_1"
	PARTITION_CHANGE_EMMC_BSP=1
fi

if [ $EXE_MTD_ROOTFS_1 != $TARGET_MTD_ROOTFS_1 ]
then
    echo "MTD_ROOTFS_1 : $TARGET_MTD_ROOTFS_1 ==> $EXE_MTD_ROOTFS_1"
	PARTITION_CHANGE_EMMC_BSP=1
fi

if [ $EXE_SECUREMAC0 != $TARGET_SECUREMAC0 ]
then
    echo "SECUREMAC0 : $TARGET_SECUREMAC0 ==> $EXE_SECUREMAC0"
	PARTITION_CHANGE_EMMC_BSP=1
fi

if [ $EXE_SECUREMAC1 != $TARGET_SECUREMAC1 ]
then
    echo "SECUREMAC1 : $TARGET_SECUREMAC1 ==> $EXE_SECUREMAC1"
	PARTITION_CHANGE_EMMC_BSP=1
fi

if [ $EXE_SECUREMAC2 != $TARGET_SECUREMAC2 ]
then
    echo "SECUREMAC2 : $TARGET_SECUREMAC2 ==> $EXE_SECUREMAC2"
	PARTITION_CHANGE_EMMC_BSP=1
fi

if [ $EXE_MTD_DRMREGION_A != $TARGET_MTD_DRMREGION_A ]
then
    echo "MTD_DRMREGION_A : $TARGET_MTD_DRMREGION_A ==> $EXE_MTD_DRMREGION_A"
	PARTITION_CHANGE_EMMC_BSP=1
fi

if [ $EXE_MTD_DRMREGION_B != $TARGET_MTD_DRMREGION_B ]
then
    echo "MTD_DRMREGION_B : $TARGET_MTD_DRMREGION_B ==> $EXE_MTD_DRMREGION_B"
	PARTITION_CHANGE_EMMC_APP=1
fi

if [ $EXE_MTD_RWAREA != $TARGET_MTD_RWAREA ]
then
    echo "MTD_RWAREA : $TARGET_MTD_RWAREA ==> $EXE_MTD_RWAREA"
	#PARTITION_CHANGE_EMMC_APP=1
	 echo "CAN NOT CHANGE THE MTD_RWAREA"
fi

if [ $EXE_MTD_EXE_0 != $TARGET_MTD_EXE_0 ]
then
    echo "MTD_EXE_0 : $TARGET_MTD_EXE_0 ==> $EXE_MTD_EXE_0"
	PARTITION_CHANGE_EMMC_APP=1
fi

if [ $EXE_MTD_EXE_1 != $TARGET_MTD_EXE_1 ]
then
    echo "MTD_EXE_1 : $TARGET_MTD_EXE_1 ==> $EXE_MTD_EXE_1"
	PARTITION_CHANGE_EMMC_APP=1
fi

if [ $EXE_MTD_ROCOMMON != $TARGET_MTD_ROCOMMON ]
then
    echo "MTD_ROCOMMON : $TARGET_MTD_ROCOMMON ==> $EXE_MTD_ROCOMMON"
	PARTITION_CHANGE_EMMC_APP=1
fi

if [ $EXE_MTD_EMANUAL != $TARGET_MTD_EMANUAL ]
then
    echo "MTD_EMANUAL : $TARGET_MTD_EMANUAL ==> $EXE_MTD_EMANUAL"
	PARTITION_CHANGE_EMMC_APP=1
fi

if [ $EXE_MTD_CONTENTS != $TARGET_MTD_CONTENTS ]
then
    echo "MTD_CONTENTS : $TARGET_MTD_CONTENTS ==> $EXE_MTD_CONTENTS"
        PARTITION_CHANGE_EMMC_APP=1
fi

if [ $EXE_MTD_SWU != $TARGET_MTD_SWU ]
then
    echo "MTD_SWU : $TARGET_MTD_SWU ==> $EXE_MTD_SWU"
       #PARTITION_CHANGE_EMMC_APP=1
	echo "CAN NOT CHANGE MTD_SWU PARTITION"
fi

if [ $EXE_MTD_RWCOMMON != $TARGET_MTD_RWCOMMON ]
then
    echo "MTD_RWCOMMON : $TARGET_MTD_RWCOMMON ==> $EXE_MTD_RWCOMMON"
	PARTITION_CHANGE_EMMC_APP=1
fi

if [ $PARTITION_CHANGE_EMMC_BSP = "0" ] && [ $PARTITION_CHANGE_EMMC_APP = "0" ]
then
        echo "partition same..."
        echo " "
        echo "=========================================="
fi

if [ $PARTITION_CHANGE_EMMC_BSP = "1" ]
then
        echo "eMMC BSP partition change..."
        echo " "
        echo "=========================================="

        echo "eMMC BSP partition change... SKIP..."
fi

if [ $PARTITION_CHANGE_EMMC_APP = "1" ]
then
	EXE_MTD_DRMREGION_A="+"$EXE_MTD_DRMREGION_A"K"
	EXE_MTD_DRMREGION_B="+"$EXE_MTD_DRMREGION_B"K"
	EXE_MTD_RWAREA="+"$EXE_MTD_RWAREA"K"
	EXE_MTD_EXE_0="+"$EXE_MTD_EXE_0"K"
	EXE_MTD_EXE_1="+"$EXE_MTD_EXE_1"K"
        EXE_MTD_ROCOMMON="+"$EXE_MTD_ROCOMMON"K"
        EXE_MTD_EMANUAL="+"$EXE_MTD_EMANUAL"K"
        EXE_MTD_CONTENTS="+"$EXE_MTD_CONTENTS"K"
        EXE_MTD_SWU="+"$EXE_MTD_SWU"K"
        EXE_MTD_RWCOMMON="+"$EXE_MTD_RWCOMMON"K"

        echo "eMMC APP partition change..."
        echo " "
        echo "=========================================="

        echo "eMMC APP partition repartition..."
        /etc/Scripts/auto_fdisk_emmc.sh
	sleep 3
	echo "Repartition end"
fi

echo "/etc/Scripts/partition_check.sh end!!!!"
