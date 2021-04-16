
FIRMWARE_AP6255_VERSION = 1.0.0
FIRMWARE_AP6255_LICENSE = Redistributable
FIRMWARE_AP6255_LICENSE_FILES = LICENSE
FIRMWARE_AP6255_SITE = $(call github,OtterCast,broadcom-firmware,v$(FIRMWARE_AP6255_VERSION))

define FIRMWARE_AP6255_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 644 $(@D)/brcmfmac43455-sdio.bin \
		$(TARGET_DIR)/usr/lib/firmware/brcm/brcmfmac43455-sdio.bin
	$(INSTALL) -D -m 644 $(@D)/brcmfmac43455-sdio.clm_blob \
		$(TARGET_DIR)/usr/lib/firmware/brcm/brcmfmac43455-sdio.clm_blob
	$(INSTALL) -D -m 644 $(@D)/brcmfmac43455-sdio.txt \
		$(TARGET_DIR)/usr/lib/firmware/brcm/brcmfmac43455-sdio.txt
	$(INSTALL) -D -m 644 $(@D)/BCM4345C0.hcd \
		$(TARGET_DIR)/usr/lib/firmware/brcm/BCM4345C0.hcd
endef

$(eval $(generic-package))
