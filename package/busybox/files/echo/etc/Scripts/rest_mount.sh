#!/bin/sh

echo "mount mtd_contents"
if [ "$(mount | grep ${MTD_CONTENTS})" == "" ]
then
	mount -t rfs $MTD_CONTENTS /mtd_contents
	if [ $? != 0 ]
	then
		umount /mtd_contents 2> /dev/null
		fat.format -F 16 -s 2 -S 4096 $MTD_CONTENTS
		mount -t rfs $MTD_CONTENTS /mtd_contents
        	if [ $? != 0 ]
        	then
        	        echo "mount mtd_contents fail"
        	fi
	fi
else
        echo "/mtd_contents already mounted"
fi

echo "mount mtd_rwcommon"
if [ "$(mount | grep ${MTD_RWCOMMON})" == "" ]
then
	mount -t rfs $MTD_RWCOMMON /mtd_rwcommon/
	if [ $? != 0 ]
	then
		umount /mtd_rwcommon 2> /dev/null
		fat.format -F 32 -s 2 -S 4096 $MTD_RWCOMMON
		mount -t rfs $MTD_RWCOMMON /mtd_rwcommon
  		if [ $? != 0 ]
        	then
        	        echo "mount mtd_rwcommon fail"
        	fi
	fi
else
        echo "/mtd_rwcommon already mounted"
fi

echo "mount mtd_emanual"
if [ "$(mount | grep ${MTD_EMANUAL})" == "" ]
then
	mount -t rfs $MTD_EMANUAL /mtd_emanual/
	if [ $? != 0 ]
	then
	        umount /mtd_emanual 2> /dev/null
	        fat.format -F 16 -s 2 -S 4096 $MTD_EMANUAL
	        mount -t rfs $MTD_EMANUAL /mtd_emanual
	        if [ $? != 0 ]
	        then
	                echo "mount mtd_emanual fail"
	        fi
	fi
else
        echo "/mtd_emanual already mounted"
fi

echo "mount mtd_swu"
if [ "$(mount | grep ${MTD_SWU})" == "" ]
then
	mount -t rfs $MTD_SWU /mtd_swu/
	if [ $? != 0 ]
	then
	        umount /mtd_swu 2> /dev/null
	        fat.format -F 16 -s 2 -S 1024 $MTD_SWU
	        mount -t rfs $MTD_SWU /mtd_swu
	        if [ $? != 0 ]
	        then
	                echo "mount mtd_swu fail"
	        fi
	fi
else
        echo "/mtd_swu already mounted"
fi

swapon /dev/ramzswap0
