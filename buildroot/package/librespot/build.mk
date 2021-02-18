#################################################################################
#
# librespot
#
################################################################################

LIBRESPOT_VERSION = 0.1.3
LIBRESPOT_SITE = $(call github,librespot-org,librespot,v$(LIBRESPOT_VERSION))
LIBRESPOT_LICENSE = MIT
LIBRESPOT_LICENSE_FILES = LICENSE
LIBRESPOT_INSTALL_TARGET = YES
LIBRESPOT_INSTALL_STAGING = YES

LIBRESPOT_DEPENDENCIES = host-rustc

LIBRESPOT_CARGO_ENV = \
    CARGO_HOME=$(HOST_DIR)/usr/share/cargo \
    RUST_TARGET_PATH=$(HOST_DIR)/etc/rustc \
    TARGET_CC=$(TARGET_CC) \
    CC=$(TARGET_CC) \
    PKG_CONFIG_ALLOW_CROSS=1

LIBRESPOT_CARGO_OPTS = \
    --target=${RUSTC_TARGET_NAME} \
    --manifest-path=$(@D)/Cargo.toml \
    --no-default-features

ifeq ($(BR2_ENABLE_DEBUG),y)
LIBRESPOT_CARGO_MODE = debug
else
LIBRESPOT_CARGO_MODE = release
endif

ifeq ($(BR2_PACKAGE_ALSA_LIB),y)
LIBRESPOT_CARGO_FEATURES += alsa-backend
endif

ifeq ($(BR2_PACKAGE_PORTAUDIO),y)
LIBRESPOT_CARGO_FEATURES += portaudio-backend
endif

ifeq ($(BR2_PACKAGE_PULSEAUDIO),y)
LIBRESPOT_CARGO_FEATURES += pulseaudio-backend
endif

LIBRESPOT_CARGO_OPTS += --${LIBRESPOT_CARGO_MODE} --features "${LIBRESPOT_CARGO_FEATURES}"

define LIBRESPOT_BUILD_CMDS
    $(TARGET_MAKE_ENV) $(LIBRESPOT_CARGO_ENV) \
            cargo build $(LIBRESPOT_CARGO_OPTS)
endef

define LIBRESPOT_INSTALL_TARGET_CMDS
    $(INSTALL) -D \
            $(@D)/target/$(RUSTC_TARGET_NAME)/$(LIBRESPOT_CARGO_MODE)/librespot \
            $(TARGET_DIR)/usr/bin/librespot
            
    $(TARGET_STRIP) --strip-all $(TARGET_DIR)/usr/bin/librespot
endef

define LIBRESPOT_INSTALL_INIT_SYSTEMD
    $(INSTALL) -D -m 644 $(LIBRESPOT_PKGDIR)/src/librespot.service \
        $(TARGET_DIR)/usr/lib/systemd/system/librespot.service

    $(INSTALL) -D -m 644 $(LIBRESPOT_PKGDIR)/src/50-librespot.preset \
        $(TARGET_DIR)/usr/lib/systemd/system-preset/50-librespot.preset
endef

$(eval $(generic-package))
