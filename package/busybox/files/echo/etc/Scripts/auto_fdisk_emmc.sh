#!/bin/sh

echo "umount mmc partitioms.."
umount /mtd_swu 2> /dev/null
umount /mtd_rocommon 2> /dev/null
umount /mtd_contents 2> /dev/null
umount /mtd_rwcommon 2> /dev/null

echo "======================= eMMC =============================="
echo ""
echo "EXE_MTD_ONBOOT		: $EXE_MTD_ONBOOT"
echo "EXE_MTD_UBOOT		: $EXE_MTD_UBOOT"
echo "EXE_MTD_KERNEL_0		: $EXE_MTD_KERNEL_0"
echo "EXE_MTD_ROOTFS_0		: $EXE_MTD_ROOTFS_0"
echo "EXE_EX_PARTITION		: $EXE_EX_PARTITION"
echo "EXE_MTD_KERNEL_1		: $EXE_MTD_KERNEL_1"
echo "EXE_MTD_ROOTFS_1		: $EXE_MTD_ROOTFS_1"
echo "EXE_SECUREMAC0		: $EXE_SECUREMAC0"
echo "EXE_SECUREMAC1		: $EXE_SECUREMAC1"
echo "EXE_SECUREMAC2		: $EXE_SECUREMAC2"
echo "EXE_MTD_DRMREGION_A	: $EXE_MTD_DRMREGION_A"
echo "EXE_MTD_DRMREGION_B	: $EXE_MTD_DRMREGION_B"
echo "EXE_MTD_RWAREA		: $EXE_MTD_RWAREA"
echo "EXE_MTD_EXE_0		: $EXE_MTD_EXE_0"
echo "EXE_MTD_EXE_1		: $EXE_MTD_EXE_1"
echo "EXE_MTD_ROCOMMON		: $EXE_MTD_ROCOMMON"
echo "EXE_MTD_EMANUAL		: $EXE_MTD_MTD_EMANUAL"
echo "EXE_MTD_CONTENTS		: $EXE_MTD_CONTENTS"
echo "EXE_MTD_SWU		: $EXE_MTD_SWU"
echo "EXE_MTD_RWCOMMON		: $EXE_MTD_RWCOMMON"
echo ""
echo "============================================================"

exe0=$EXE_MTD_EXE_0
exe1=$EXE_MTD_EXE_1
ro_common=$EXE_MTD_ROCOMMON
emanual=$EXE_MTD_EMANUAL
contents=$EXE_MTD_CONTENTS
swu=$EXE_MTD_SWU
rw_common=$EXE_MTD_RWCOMMON

exec fdisk -u /dev/mmcblk0 << End
d

19

d

18

d

17

d

16

d

15

d

14

d

13

n

$exe0
n

$exe1
n

$ro_common
n

$emanual
n

$contents
n

$swu
n

$rw_common

p


w

End
