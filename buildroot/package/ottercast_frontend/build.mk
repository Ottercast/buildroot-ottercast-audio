################################################################################
#
# ottercast_frontend
#
################################################################################

OTTERCAST_FRONTEND_VERSION = 0.1.1
OTTERCAST_FRONTEND_LICENSE = MIT
OTTERCAST_FRONTEND_LICENSE_FILES = LICENSE
OTTERCAST_FRONTEND_SITE = $(call github,Ottercast,frontend,v$(OTTERCAST_FRONTEND_VERSION))
OTTERCAST_FRONTEND_DEPENDENCIES = dbus imagemagick libcurl
OTTERCAST_FRONTEND_INSTALL_TARGET = YES
OTTERCAST_FRONTEND_INSTALL_STAGING = YES

define OTTERCAST_FRONTEND_BUILD_CMDS
    $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) all
endef

define OTTERCAST_FRONTEND_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 644 $(OTTERCAST_FRONTEND_PKGDIR)/src/ottercast-frontend.service $(TARGET_DIR)/usr/lib/systemd/system/ottercast-frontend.service
	$(INSTALL) -D -m 644 $(OTTERCAST_FRONTEND_PKGDIR)/src/50-ottercast-frontend.preset $(TARGET_DIR)/usr/lib/systemd/system-preset/50-ottercast-frontend.preset

	$(TARGET_CONFIGURE_OPTS) DESTDIR=$(TARGET_DIR) $(MAKE) -C $(@D) install
endef

$(eval $(generic-package))
