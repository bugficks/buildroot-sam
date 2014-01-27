#!/bin/sh
echo "/etc/Scripts stand_alone_upgrade.sh  start!!!"

SUCCESS_COPY="true"
SWU_DEPOT=/mtd_swu/standalone
EXE_DEPOT=/mtd_exe/StandAlone

if [ -e /mtd_rwarea/UPGRADE_ROLLBACK ];then
	echo "UPGRADE_ROLLBACK flag is found!"
	ln -s $SWU_DEPOT/.info /dtv/.info
  	insmod $SWU_DEPOT/samdrv.ko
  	echo "umount mtd_exe,mtd_rocommon,mtd_appext..."
    	if [ "$(mount | grep ${MTD_EXE_0_STL})" == "" ]; then
        	echo "/mtd_exe is already umounted."
    	else
        	count=1

        	umount /mtd_exe
        	while [ $? != 0 ] && [ "$count" -le 10 ]
        	do
                	sleep 1
                	count=$(($count+1))
               	 	echo "retry umount : $count time"
                	umount /mtd_exe
        	done

        	if [ "$count" = 11 ]; then
                	echo "/mtd_exe umount fail!"
                	SUCCESS_COPY="false"
        	fi
    	fi


        umount /mtd_rocommon
    	if [ $? != 0 ];then
                echo "/mtd_rocommon umount fail!!!"
        SUCCESS_COPY="false"
    	fi

        umount /mtd_appext
    	if [ $? != 0 ];then
                echo "/mtd_appext umount fail!!!"
        	SUCCESS_COPY="false"
    	fi
	
	$SWU_DEPOT/StandAlone.sh -rollback	
else
	
	if [ ! -e /mtd_rwarea/UPGRADE_FACTORY ] || [ ! -e /mtd_rwarea/UPGRADE_FAIL ]; then
		touch /mtd_rwarea/UPGRADE_FAIL
		cp /mtd_exe/.info $SWU_DEPOT
		cp /mtd_exe/partition.txt $SWU_DEPOT
		cp $EXE_DEPOT/*.so $SWU_DEPOT
		cp $EXE_DEPOT/StandAlone.sh $SWU_DEPOT
		cp $EXE_DEPOT/StandAloneUpgrade $SWU_DEPOT
		/etc/Scripts/stand_alone_copy.sh
		cp /mtd_exe/lib/*.so $SWU_DEPOT
    		if [ $? != 0 ];then
        		SUCCESS_COPY="false"
    		fi

    		echo "Copy cfg file..."
    		cp /mtd_exe/*.cfg $SWU_DEPOT
    		if [ $? != 0 ];then
        		SUCCESS_COPY="false"
    		fi

		cp /mtd_exe/samdrv.ko $SWU_DEPOT
    		if [ $? != 0 ];then
        		SUCCESS_COPY="false"
    		fi
	

		ln -s $SWU_DEPOT/libSDAL.so $SWU_DEPOT/libSDAL.so.1

		cp /mtd_exe/standalone_bg.bmp $SWU_DEPOT
    		if [ $? != 0 ];then
       	 		SUCCESS_COPY="false"
    		fi

		cp /mtd_exe/standalone_progress_bg.bmp $SWU_DEPOT
    		if [ $? != 0 ];then
       	 		SUCCESS_COPY="false"
    		fi

		cp /mtd_exe/standalone_progress_unit.bmp $SWU_DEPOT
    		if [ $? != 0 ];then
        		SUCCESS_COPY="false"
    		fi

		sync

		#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$SWU_DEPOT
	fi

	ln -s $SWU_DEPOT/.info /dtv/.info
	insmod $SWU_DEPOT/samdrv.ko	
    	echo "umount mtd_exe,mtd_rocommon,mtd_appext..."
    
    	if [ "$(mount | grep ${MTD_EXE_0_STL})" == "" ]; then
		echo "/mtd_exe is already umounted."
    	else
		count=1

		umount /mtd_exe
		while [ $? != 0 ] && [ "$count" -le 10 ]
		do
			sleep 1
			count=$(($count+1))
			echo "retry umount : $count time"
			umount /mtd_exe
		done

		if [ "$count" = 11 ]; then
			echo "/mtd_exe umount fail!"
			SUCCESS_COPY="false"
		fi
    	fi


	umount /mtd_rocommon
    	if [ $? != 0 ];then
		echo "/mtd_rocommon umount fail!!!"
        SUCCESS_COPY="false"
    	fi

	umount /mtd_appext
    	if [ $? != 0 ];then
		echo "/mtd_appext umount fail!!!"
        	SUCCESS_COPY="false"
    	fi

	if [ "$SUCCESS_COPY" = "true" ] ; then	
		$SWU_DEPOT/StandAlone.sh
	else
		$SWU_DEPOT/StandAlone.sh -copyfail		
	fi
fi

echo "Reboot system..."
$MICOM_BASE/reboot
sleep 3

echo "/etc/Scripts stand_alone_upgrade.sh  end!!!"
