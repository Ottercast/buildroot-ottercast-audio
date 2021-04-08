#################################################################################
#
# Spotifyd
#
################################################################################

SPOTIFYD_VERSION = 0.3.2
SPOTIFYD_SITE = $(call github,Spotifyd,spotifyd,v$(SPOTIFYD_VERSION))
SPOTIFYD_LICENSE = MIT
SPOTIFYD_LICENSE_FILES = LICENSE
SPOTIFYD_INSTALL_TARGET = YES
SPOTIFYD_INSTALL_STAGING = YES

SPOTIFYD_DEPENDENCIES = host-rustc

SPOTIFYD_CARGO_ENV = \
    CARGO_HOME=$(HOST_DIR)/usr/share/cargo \
    RUST_TARGET_PATH=$(HOST_DIR)/etc/rustc \
    TARGET_CC=$(TARGET_CC) \
    CC=$(TARGET_CC) \
    PKG_CONFIG_ALLOW_CROSS=1

SPOTIFYD_CARGO_OPTS = \
    --target=${RUSTC_TARGET_NAME} \
    --manifest-path=$(@D)/Cargo.toml \
    --no-default-features

SPOTIFYD_CARGO_FEATURES = dbus_mpris

ifeq ($(BR2_ENABLE_DEBUG),y)
SPOTIFYD_CARGO_MODE = debug
else
SPOTIFYD_CARGO_MODE = release
endif

ifeq ($(BR2_PACKAGE_ALSA_LIB),y)
SPOTIFYD_CARGO_FEATURES += alsa_backend
endif

ifeq ($(BR2_PACKAGE_PORTAUDIO),y)
SPOTIFYD_CARGO_FEATURES += portaudio_backend
endif

ifeq ($(BR2_PACKAGE_PULSEAUDIO),y)
SPOTIFYD_CARGO_FEATURES += pulseaudio_backend
endif

SPOTIFYD_CARGO_OPTS += --${SPOTIFYD_CARGO_MODE} --features "${SPOTIFYD_CARGO_FEATURES}"

define SPOTIFYD_BUILD_CMDS
    $(TARGET_MAKE_ENV) $(SPOTIFYD_CARGO_ENV) \
            cargo build $(SPOTIFYD_CARGO_OPTS)
endef

define SPOTIFYD_INSTALL_TARGET_CMDS
    $(INSTALL) -D \
            $(@D)/target/$(RUSTC_TARGET_NAME)/$(SPOTIFYD_CARGO_MODE)/spotifyd \
            $(TARGET_DIR)/usr/bin/spotifyd
            
    $(TARGET_STRIP) --strip-all $(TARGET_DIR)/usr/bin/spotifyd
endef

define SPOTIFYD_INSTALL_INIT_SYSTEMD
    $(INSTALL) -D -m 644 $(SPOTIFYD_PKGDIR)/src/spotifyd.service \
        $(TARGET_DIR)/usr/lib/systemd/system/spotifyd.service

    $(INSTALL) -D -m 644 $(SPOTIFYD_PKGDIR)/src/50-spotifyd.preset \
        $(TARGET_DIR)/usr/lib/systemd/system-preset/50-spotifyd.preset
endef

$(eval $(generic-package))
