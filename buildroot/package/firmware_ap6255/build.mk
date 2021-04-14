
FIRMWARE_AP6255_VERSION = 1.1.1
FIRMWARE_AP6255_LICENSE = Proprietary
FIRMWARE_AP6255_SOURCE =
FIRMWARE_AP6255_SITE =

define FIRMWARE_AP6255_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 644 $(FIRMWARE_AP6255_PKGDIR)/firmware/brcmfmac43455-sdio.bin \
		$(TARGET_DIR)/usr/lib/firmware/brcm/brcmfmac43455-sdio.bin
	$(INSTALL) -D -m 644 $(FIRMWARE_AP6255_PKGDIR)/firmware/brcmfmac43455-sdio.clm_blob \
		$(TARGET_DIR)/usr/lib/firmware/brcm/brcmfmac43455-sdio.clm_blob
	$(INSTALL) -D -m 644 $(FIRMWARE_AP6255_PKGDIR)/firmware/brcmfmac43455-sdio.txt \
		$(TARGET_DIR)/usr/lib/firmware/brcm/brcmfmac43455-sdio.txt
	$(INSTALL) -D -m 644 $(FIRMWARE_AP6255_PKGDIR)/firmware/BCM4345C0.hcd \
		$(TARGET_DIR)/usr/lib/firmware/brcm/BCM4345C0.hcd
endef

$(eval $(generic-package))
