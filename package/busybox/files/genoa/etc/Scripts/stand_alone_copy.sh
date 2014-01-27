EXE_STANDALONE_DIR=/mtd_exe/StandAlone
STANDALONE_DIR=/mtd_swu/StandAlone

SWU_LANG_US_NAME=/mtd_swu/StandAlone/SWU_LANG_US
SWU_LANG_KR_NAME=/mtd_swu/StandAlone/SWU_LANG_KO
SWU_LANG_JP_NAME=/mtd_swu/StandAlone/SWU_LANG_JP
SWU_LANG_EU_NAME=/mtd_swu/StandAlone/SWU_LANG_EU
SWU_LANG_S_CN_NAME=/mtd_swu/StandAlone/SWU_LANG_S_CN
SWU_LANG_T_CN_NAME=/mtd_swu/StandAlone/SWU_LANG_T_CN

SWU_FONT_KR_NAME=shadow_ko.ttf
SWU_FONT_US_NAME=shadow_us.ttf
SWU_FONT_JP_NAME=shadow_jp.ttf
SWU_FONT_EU_NAME=shadow_eu.ttf
SWU_FONT_S_CN_NAME=shadow_s_cn.ttf
SWU_FONT_T_CN_NAME=shadow_t_cn.ttf

check_font()
{
	echo "SWU_LANG_US_NAME : $SWU_LANG_US_NAME"
	if [ -e $SWU_LANG_US_NAME ]
	then	
		echo "OK : $SWU_LANG_US_NAME"	
		process $SWU_LANG_US_NAME
		process $SWU_LANG_EU_NAME			
	else
		echo "NOT OK : $SWU_LANG_US_NAME"
	fi
		
	echo "SWU_LANG_KR_NAME : $SWU_LANG_KR_NAME"
	if [ -e $SWU_LANG_KR_NAME ];then		
		process $SWU_LANG_KR_NAME		
	else
		echo "NOT OK : $SWU_LANG_KR_NAME"
	fi	
	
	echo "SWU_LANG_JP_NAME : $SWU_LANG_JP_NAME"
	if [ -e $SWU_LANG_JP_NAME ];then		
		process $SWU_LANG_JP_NAME		
	else
		echo "NOT OK : $SWU_LANG_JP_NAME"	
	fi
	
	echo "SWU_LANG_EU_NAME : $SWU_LANG_EU_NAME"
	if [ -e $SWU_LANG_EU_NAME ];then		
		process $SWU_LANG_EU_NAME		
	else
		echo "NOT OK : $SWU_LANG_EU_NAME"
	fi
	
	echo "SWU_LANG_S_CN_NAME : $SWU_LANG_S_CN_NAME"
	if [ -e $SWU_LANG_S_CN_NAME ];then		
		process $SWU_LANG_S_CN_NAME		
	else
		echo "NOT OK : $SWU_LANG_S_CN_NAME"	
	fi
	
	echo "SWU_LANG_T_CN_NAME : $SWU_LANG_T_CN_NAME"
	if [ -e $SWU_LANG_T_CN_NAME ];then		
		process $SWU_LANG_T_CN_NAME		
	else
		echo "NOT OK : $SWU_LANG_T_CN_NAME"	
	fi
}

process()
{
	case $1 in
		$SWU_LANG_US_NAME)
		copy_font $SWU_FONT_US_NAME
		copy_font $SWU_FONT_EU_NAME
		;;
		$SWU_LANG_KR_NAME)
		copy_font $SWU_FONT_KR_NAME
		;;
		$SWU_LANG_JP_NAME)
		copy_font $SWU_FONT_JP_NAME
		;;
		$SWU_LANG_EU_NAME)
		copy_font $SWU_FONT_EU_NAME
		;;
		$SWU_LANG_S_CN_NAME)
		copy_font $SWU_FONT_S_CN_NAME
		;;
		$SWU_LANG_T_CN_NAME)
		copy_font $SWU_FONT_T_CN_NAME
		;;
		*)
		exit 1		
		;;
	esac		
}

copy_font()
{
	echo "copy : $EXE_STANDALONE_DIR/$1 $STANDALONE_DIR/$1"
	cp $EXE_STANDALONE_DIR/$1 $STANDALONE_DIR/$1
}

check_font
