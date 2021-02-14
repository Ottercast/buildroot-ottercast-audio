################################################################################
#
# ottercast_webinterface
#
################################################################################

OTTERCAST_WEBINTERFACE_VERSION = 0.1
OTTERCAST_WEBINTERFACE_SITE = $(call github,Manawyrm,ottercast-audio-webif,v$(OTTERCAST_WEBINTERFACE_VERSION))
OTTERCAST_WEBINTERFACE_LICENSE = MIT
OTTERCAST_WEBINTERFACE_LICENSE_FILES = LICENSE
OTTERCAST_WEBINTERFACE_INSTALL_TARGET = YES
OTTERCAST_WEBINTERFACE_INSTALL_STAGING = YES

define OTTERCAST_WEBINTERFACE_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/var/www/
	cp -r $(@D)/* $(TARGET_DIR)/var/www/

	cp -r $(OTTERCAST_WEBINTERFACE_PKGDIR)/ottercast-config.service $(TARGET_DIR)/usr/lib/systemd/system/
	ln -s usr/lib/systemd/system/ottercast-config.service $(TARGET_DIR)/usr/lib/systemd/system/multi-user.target.wants/ottercast-config.service

	mkdir -p $(TARGET_DIR)/etc/default/
	cp $(OTTERCAST_WEBINTERFACE_PKGDIR)/librespot $(TARGET_DIR)/etc/default/librespot 
	cp $(OTTERCAST_WEBINTERFACE_PKGDIR)/uhttpd $(TARGET_DIR)/etc/default/uhttpd
endef

$(eval $(generic-package))
