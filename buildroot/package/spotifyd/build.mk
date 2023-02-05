#################################################################################
#
# Spotifyd
#
################################################################################

SPOTIFYD_VERSION = 0.3.4
SPOTIFYD_SITE = $(call github,Spotifyd,spotifyd,v$(SPOTIFYD_VERSION))
SPOTIFYD_LICENSE = MIT
SPOTIFYD_LICENSE_FILES = LICENSE
SPOTIFYD_INSTALL_TARGET = YES
SPOTIFYD_INSTALL_STAGING = YES
SPOTIFYD_DEPENDENCIES = dbus host-pkgconf

SPOTIFYD_CARGO_FEATURES = dbus_mpris

ifeq ($(BR2_PACKAGE_ALSA_LIB),y)
SPOTIFYD_CARGO_FEATURES += alsa_backend
SPOTIFYD_DEPENDENCIES += alsa-lib
endif

ifeq ($(BR2_PACKAGE_PORTAUDIO),y)
SPOTIFYD_CARGO_FEATURES += portaudio_backend
endif

ifeq ($(BR2_PACKAGE_PULSEAUDIO),y)
SPOTIFYD_CARGO_FEATURES += pulseaudio_backend
SPOTIFYD_DEPENDENCIES += pulseaudio
endif

SPOTIFYD_CARGO_BUILD_OPTS += --features "$(SPOTIFYD_CARGO_FEATURES)"
SPOTIFYD_CARGO_INSTALL_OPTS += --features "$(SPOTIFYD_CARGO_FEATURES)"

define SPOTIFYD_INSTALL_INIT_SYSTEMD
    $(INSTALL) -D -m 644 $(SPOTIFYD_PKGDIR)/src/spotifyd.service \
        $(TARGET_DIR)/usr/lib/systemd/system/spotifyd.service

    $(INSTALL) -D -m 644 $(SPOTIFYD_PKGDIR)/src/50-spotifyd.preset \
        $(TARGET_DIR)/usr/lib/systemd/system-preset/50-spotifyd.preset
endef

$(eval $(cargo-package))
