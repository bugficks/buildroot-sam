#############################################################
#
# apache
#
#############################################################
APACHE_VERSION    = 2.2.19
#APACHE_SITE       = http://mir2.ovh.net/ftp.apache.org/dist/httpd/
APACHE_SITE       = http://archive.apache.org/dist/httpd/
APACHE_SOURCE = httpd-$(APACHE_VERSION).tar.bz2
APACHE_INSTALL_STAGING = YES
APACHE_INSTALL_TARGET = YES
APACHE_AUTORECONF = YES

APACHE_CONF_ENV += \
	ac_cv_file__dev_zero=yes \
	ac_cv_func_setpgrp_void=yes \
	apr_cv_tcp_nodelay_with_cork=yes \
	ac_cv_sizeof_struct_iovec=8 \
	apr_cv_process_shared_works=yes \
	apr_cv_mutex_robust_shared=no \
	ac_cv_struct_rlimit=yes \
	ap_cv_void_ptr_lt_long=no \
	CC="$(TARGET_CC)" \
	CFLAGS="$(TARGET_CFLAGS) -DBIG_SECURITY_HOLE" \
	LDFLAGS="$(TARGET_LDFLAGS)" \

APACHE_CONF_OPT += \
	--host="arm-linux" \
	--prefix="/usr/local/apache2" \
	--enable-so \
	--enable-module=all


	
		
		
define APACHE_CONFIGURE_CMDS
	(cd $(@D) && rm -rf config.cache; \
	        $(APACHE_CONF_ENV) \
		./configure \
		$(APACHE_CONF_OPT) \
	)
endef

define APACHE_INSTALL_INITSCRIPTS_CONFIG
	# install start/stop script
	@if [ ! -f $(TARGET_DIR)/etc/init.d/S91apache2 ]; then \
		$(INSTALL) -m 0755 -D package/apache/S91apache2 $(TARGET_DIR)/etc/init.d/S91apache2; \
		$(INSTALL) -m 0755 -D package/apache/httpd.conf $(TARGET_DIR)/etc/httpd.conf; \
	fi

	fi
endef




$(eval $(autotools-package))
