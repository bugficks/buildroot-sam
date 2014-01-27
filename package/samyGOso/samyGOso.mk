################################################################################
#
# samyGOso
#
################################################################################

SAMYGOSO_SITE = http://www.samygo.tv/juzis28/buildroot
SAMYGOSO_SOURCE = samyGOso.tar.gz
SAMYGOSO_VERSION = 1.1

define SAMYGOSO_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) all
endef

define SAMYGOSO_INSTALL_TARGET_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) install
endef

$(eval $(generic-package))
