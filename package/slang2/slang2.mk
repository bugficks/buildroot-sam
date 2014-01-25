#############################################################
#
# slang2
#
#############################################################
#SLANG2_VERSION:=2.1.4
#SLANG2_SOURCE=slang-$(SLANG2_VERSION).tar.bz2
#SLANG2_CAT:=$(BZCAT)
#SLANG2_SITE:=ftp://space.mit.edu/pub/davis/slang/v2.1
#SLANG2_DIR=$(BUILD_DIR)/slang-$(SLANG2_VERSION)

SLANG2_VERSION = 2.2.3
SLANG2_SOURCE = slang-$(SLANG_VERSION)-mini.tar.bz2
SLANG2_SITE = ftp://space.mit.edu/pub/davis/slang/v2.2
SLANG2_INSTALL_STAGING = YES
SLANG2_DIR=$(BUILD_DIR)/slang-$(SLANG2_VERSION)


define SLANG2_BUILD_CMDS
	$(MAKE1) CC="$(TARGET_CC)" CFLAGS="$(TARGET_CFLAGS) -fPIC" \
	LDFLAGS="$(TARGET_LDFLAGS)" -C $(@D)
endef

define SLANG2_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 0644 $(@D)/libslang.a $(STAGING_DIR)/usr/lib/libslang.a
	$(INSTALL) -D -m 0755 $(@D)/libslang.so $(STAGING_DIR)/usr/lib/libslang.so
	$(INSTALL) -D -m 0644 $(@D)/slang.h $(STAGING_DIR)/usr/include/slang.h
	$(INSTALL) -D -m 0644 $(@D)/slcurses.h $(STAGING_DIR)/usr/include/slcurses.h
	(cd $(STAGING_DIR)/usr/lib; ln -fs libslang.so libslang.so.2)
endef

define SLANG2_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0644 $(@D)/libslang.a $(TARGET_DIR)/usr/lib/libslang.a
	$(INSTALL) -D -m 0755 $(@D)/libslang.so $(TARGET_DIR)/usr/lib/libslang.so
	$(INSTALL) -D -m 0644 $(@D)/slang.h $(TARGET_DIR)/usr/include/slang.h
	$(INSTALL) -D -m 0644 $(@D)/slcurses.h $(TARGET_DIR)/usr/include/slcurses.h
	(cd $(TARGET_DIR)/usr/lib; ln -fs libslang.so libslang.so.2)
endef

define SLANG2_UNINSTALL_STAGING_CMDS
	rm -f $(STAGING_DIR)/usr/lib/libslang.a
	rm -f $(STAGING_DIR)/usr/lib/libslang.so
	rm -f $(STAGING_DIR)/usr/lib/libslang.so.1
	rm -f $(STAGING_DIR)/usr/include/slang.h
	rm -f $(STAGING_DIR)/usr/include/slcurses.h
endef

define SLANG2_UNINSTALL_TARGET_CMDS
	rm -f $(TARGET_DIR)/usr/lib/libslang.a
	rm -f $(TARGET_DIR)/usr/lib/libslang.so
	rm -f $(TARGET_DIR)/usr/lib/libslang.so.1
	rm -f $(TARGET_DIR)/usr/include/slang.h
	rm -f $(TARGET_DIR)/usr/include/slcurses.h
endef

define SLANG2_CLEAN_CMDS
	$(MAKE) -C $(@D) clean
endef

$(eval $(generic-package))