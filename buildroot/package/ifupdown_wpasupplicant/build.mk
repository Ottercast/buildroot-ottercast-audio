
IFUPDOWN_WPASUPPLICANT_VERSION = 2.9.0-20
IFUPDOWN_WPASUPPLICANT_SITE = https://salsa.debian.org/debian/wpa/-/archive/debian/2%$(IFUPDOWN_WPASUPPLICANT_VERSION)
IFUPDOWN_WPASUPPLICANT_SOURCE = wpa-debian-2%$(IFUPDOWN_WPASUPPLICANT_VERSION).tar.gz
IFUPDOWN_WPASUPPLICANT_LICENSE = GPL

define IFUPDOWN_WPASUPPLICANT_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 755 $(@D)/debian/ifupdown/functions.sh \
		$(TARGET_DIR)/etc/wpa_supplicant/functions.sh

	$(INSTALL) -D -m 755 $(@D)/debian/ifupdown/action_wpa.sh \
		$(TARGET_DIR)/etc/wpa_supplicant/action_wpa.sh

	$(INSTALL) -D -m 755 $(@D)/debian/ifupdown/wpasupplicant/ifupdown.sh \
		$(TARGET_DIR)/etc/wpa_supplicant/ifupdown.sh

	ln -fs /etc/wpa_supplicant/ifupdown.sh \
		$(TARGET_DIR)/etc/network/if-pre-up.d/wpasupplicant

	ln -fs /etc/wpa_supplicant/ifupdown.sh \
		$(TARGET_DIR)/etc/network/if-up.d/wpasupplicant

	ln -fs /etc/wpa_supplicant/ifupdown.sh \
		$(TARGET_DIR)/etc/network/if-down.d/wpasupplicant

	ln -fs /etc/wpa_supplicant/ifupdown.sh \
		$(TARGET_DIR)/etc/network/if-post-down.d/wpasupplicant

endef

$(eval $(generic-package))
