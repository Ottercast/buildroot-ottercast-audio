
FIRMWARE_AP6236_VERSION = 1.1.1
FIRMWARE_AP6236_LICENSE = Proprietary
FIRMWARE_AP6236_SOURCE =
FIRMWARE_AP6236_SITE =

define FIRMWARE_AP6236_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 644 $(FIRMWARE_AP6236_PKGDIR)/firmware/nvram_ap6236.txt $(TARGET_DIR)/usr/lib/firmware/brcm/brcmfmac43430-sdio.txt
	$(INSTALL) -D -m 644 $(FIRMWARE_AP6236_PKGDIR)/firmware/fw_bcm43436b0.bin $(TARGET_DIR)/usr/lib/firmware/brcm/brcmfmac43430-sdio.bin
endef

$(eval $(generic-package))
