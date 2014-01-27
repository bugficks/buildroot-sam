############################################################# 
#                                                             
# mc                                                          
#                                                             
############################################################# 
NTPCLIENT_VERSION:=365
NTPCLIENT_SOURCE:=ntpclient_2010_$(NTPCLIENT_VERSION).tar.gz
NTPCLIENT_SITE:=http://doolittle.icarus.com/ntpclient/
NTPCLIENT_INSTALL_TARGET=YES
NTPCLIENT_LICENSE = GPLv2+                                                 

define NTPCLIENT_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) all
endef

define NTPCLIENT_INSTALL_TARGET_CMDS
	cp $(@D)/ntpclient $(TARGET_DIR)/usr/sbin
	cp package/ntpclient/S50ntpclient $(TARGET_DIR)/etc/init.d
endef


$(eval $(generic-package))