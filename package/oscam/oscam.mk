################################################################################
#
# oscam
#
################################################################################

OSCAM_SITE = http://www.streamboard.tv/svn/oscam/trunk
OSCAM_SITE_METHOD = svn
OSCAM_VERSION = 8984

define OSCAM_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) CONF_DIR=/etc/oscam OSCAM_BIN=oscam-samygo
endef

define OSCAM_INSTALL_TARGET_CMDS
	cp $(@D)/oscam-samygo $(TARGET_DIR)/usr/bin
	cp -Rf  package/oscam/files/* $(TARGET_DIR)/
	chmod 776 $(TARGET_DIR)/usr/bin/oscam-samygo
	cd ${TARGET_DIR}/usr/bin/ && ln -fs oscam-samygo oscam
endef

$(eval $(generic-package))
