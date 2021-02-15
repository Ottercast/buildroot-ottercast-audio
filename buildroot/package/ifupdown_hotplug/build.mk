
IFUPDOWN_HOTPLUG_VERSION = 0.0.1
IFUPDOWN_HOTPLUG_SITE =
IFUPDOWN_HOTPLUG_SOURCE =
IFUPDOWN_HOTPLUG_LICENSE = GPL

define IFUPDOWN_HOTPLUG_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 644 $(IFUPDOWN_HOTPLUG_PKGDIR)/src/80-ifupdown.rules \
		$(TARGET_DIR)/lib/udev/rules.d/80-ifupdown.rules

	$(INSTALL) -D -m 755 $(IFUPDOWN_HOTPLUG_PKGDIR)/src/ifupdown-hotplug \
		$(TARGET_DIR)/lib/udev/ifupdown-hotplug
endef

$(eval $(generic-package))
