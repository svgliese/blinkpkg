################################################################################
#
# blinkpkg
#
################################################################################

BLINKPKG_VERSION = 221b942355ada6b598db3d63c94c697b73433545
BLINKPKG_SITE = $(call github,svgliese,blink,$(BLINKPKG_VERSION))
BLINKPKG_LICENSE = Public Domain
BLINKPKG_LICENSE_FILES = readme.txt

define BLINKPKG_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)
endef

define BLINKPKG_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/blink $(TARGET_DIR)/usr/bin/blink
        $(INSTALL) -m 0755 -D $(@D)/S50blink $(TARGET_DIR)/etc/init.d
endef

$(eval $(generic-package))
