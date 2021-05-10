################################################################################
#
# ottercast_displayboot
#
################################################################################

OTTERCAST_DISPLAYBOOT_VERSION = 0.1.1
OTTERCAST_DISPLAYBOOT_SITE = $(call github,Ottercast,displayboot,v$(OTTERCAST_DISPLAYBOOT_VERSION))
OTTERCAST_DISPLAYBOOT_LICENSE = MIT
OTTERCAST_DISPLAYBOOT_LICENSE_FILES = LICENSE
OTTERCAST_DISPLAYBOOT_DEPENDENCIES = freetype libpng
OTTERCAST_DISPLAYBOOT_INSTALL_TARGET = YES
OTTERCAST_DISPLAYBOOT_INSTALL_STAGING = YES

define OTTERCAST_DISPLAYBOOT_BUILD_CMDS
    $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) all
endef

define OTTERCAST_DISPLAYBOOT_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 644 $(OTTERCAST_DISPLAYBOOT_PKGDIR)/src/ottercast-displayboot.service $(TARGET_DIR)/usr/lib/systemd/system/ottercast-displayboot.service

	$(TARGET_CONFIGURE_OPTS) DESTDIR=$(TARGET_DIR) $(MAKE) -C $(@D) install
endef

$(eval $(generic-package))
