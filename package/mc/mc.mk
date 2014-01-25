############################################################# 
#                                                             
# mc                                                          
#                                                             
############################################################# 
MC_VERSION:=4.8.0
MC_SOURCE:=mc-$(MC_VERSION).tar.bz2
MC_SITE:=http://www.midnight-commander.org/downloads
MC_INSTALL_TARGET=YES
MC_LICENSE = GPLv2+                                       
MC_DEPENDENCIES = host-pkgconf libglib2 ncurses            

MC_CONF_OPT += \
	fu_cv_sys_stat_statfs2_bsize=yes \
	--with-screen=ncurses \
	--with-ncurses-libs=$(STAGING_DIR)/usr/lib \
	--with-ncurses-includes=$(STAGING_DIR)/usr/include \
	--disable-rpath
define MC_FIX_NCURSES_INCLUDE_DIR        
	/bin/mkdir -p $(STAGING_DIR)/usr/include/ncurses
	/bin/cp -dpf $(STAGING_DIR)/usr/include/curses.h $(STAGING_DIR)/usr/include/ncurses/curses.h
	/bin/cp -dpf $(STAGING_DIR)/usr/include/term.h $(STAGING_DIR)/usr/include/ncurses/term.h
	(cd $(STAGING_DIR)/usr/include/ncurses; /bin/ln -fs curses.h ncurses.h)endef
endef
$(eval $(autotools-package))