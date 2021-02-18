################################################################################
#
# ottercast_webinterface
#
################################################################################

OTTERCAST_WEBINTERFACE_VERSION = 0.3
OTTERCAST_WEBINTERFACE_SITE = $(call github,Ottercast,webinterface,v$(OTTERCAST_WEBINTERFACE_VERSION))
OTTERCAST_WEBINTERFACE_LICENSE = MIT
OTTERCAST_WEBINTERFACE_LICENSE_FILES = LICENSE
OTTERCAST_WEBINTERFACE_INSTALL_TARGET = YES
OTTERCAST_WEBINTERFACE_INSTALL_STAGING = YES

define OTTERCAST_WEBINTERFACE_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/var/www/
	cp -r $(@D)/* $(TARGET_DIR)/var/www/

	$(INSTALL) -D -m 0644 $(OTTERCAST_WEBINTERFACE_PKGDIR)/src/ottercast-config.service $(TARGET_DIR)/usr/lib/systemd/system/
	ln -fs /usr/lib/systemd/system/ottercast-config.service $(TARGET_DIR)/usr/lib/systemd/system/multi-user.target.wants/ottercast-config.service

	mkdir -p $(TARGET_DIR)/etc/wpa_supplicant/
	$(INSTALL) -D -m 0644 $(OTTERCAST_WEBINTERFACE_PKGDIR)/src/librespot $(TARGET_DIR)/etc/default/librespot
	$(INSTALL) -D -m 0644 $(OTTERCAST_WEBINTERFACE_PKGDIR)/src/uhttpd $(TARGET_DIR)/etc/default/uhttpd

	$(INSTALL) -D -m 0644 $(@D)/example_config.sh  $(BINARIES_DIR)/config.sh
endef

$(eval $(generic-package))
