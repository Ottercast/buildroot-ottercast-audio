################################################################################
#
# ottercast_webinterface
#
################################################################################

OTTERCAST_WEBINTERFACE_VERSION = 0.6.1
OTTERCAST_WEBINTERFACE_SITE = $(call github,Ottercast,webinterface,v$(OTTERCAST_WEBINTERFACE_VERSION))
OTTERCAST_WEBINTERFACE_LICENSE = MIT
OTTERCAST_WEBINTERFACE_LICENSE_FILES = LICENSE
OTTERCAST_WEBINTERFACE_INSTALL_TARGET = YES
OTTERCAST_WEBINTERFACE_INSTALL_STAGING = YES

define OTTERCAST_WEBINTERFACE_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/opt/ottercast/
	cp -rp $(@D)/* $(TARGET_DIR)/opt/ottercast/
	chmod +x $(TARGET_DIR)/opt/ottercast/public/cgi-bin/ottercast

	ln -fs ../opt/ottercast/public/ $(TARGET_DIR)/var/www

	$(INSTALL) -D -m 0644 $(OTTERCAST_WEBINTERFACE_PKGDIR)/src/ottercast-config.service $(TARGET_DIR)/usr/lib/systemd/system/
	ln -fs /usr/lib/systemd/system/ottercast-config.service $(TARGET_DIR)/usr/lib/systemd/system/multi-user.target.wants/ottercast-config.service

	mkdir -p $(TARGET_DIR)/etc/wpa_supplicant/
	$(INSTALL) -D -m 0644 $(OTTERCAST_WEBINTERFACE_PKGDIR)/src/spotifyd $(TARGET_DIR)/etc/default/spotifyd
	$(INSTALL) -D -m 0644 $(OTTERCAST_WEBINTERFACE_PKGDIR)/src/uhttpd $(TARGET_DIR)/etc/default/uhttpd
	$(INSTALL) -D -m 0644 $(OTTERCAST_WEBINTERFACE_PKGDIR)/src/shairport-sync $(TARGET_DIR)/etc/default/shairport-sync

	$(INSTALL) -D -m 0644 $(@D)/example_config.ini  $(BINARIES_DIR)/config.ini
endef

$(eval $(generic-package))
