#
# Copyright (C) 2020 [CTCGFW]Project-OpenWrt
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=cgroup
PKG_VERSION:=1.8.3
PKG_RELEASE:=1

PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/iptables-mod-cgroup
  SUBMENU:=Firewall
  SECTION:=net
  CATEGORY:=Network
  TITLE:=cgroup iptables extension 
  DEPENDS:=+iptables +kmod-ipt-cgroup
  MAINTAINER:=[CTCGFW]Project-OpenWrt
endef

define Package/iptables-mod-cgroup/install
	$(INSTALL_DIR) $(1)/usr/lib/iptables
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/libipt_cgroup.so $(1)/usr/lib/iptables/libipt_cgroup.so
endef

define KernelPackage/ipt-cgroup
  SUBMENU:=Netfilter Extensions
  TITLE:=cgroup netfilter module
  DEPENDS:=+kmod-ipt-core
  MAINTAINER:=[CTCGFW]Project-OpenWrt
  FILES:=$(PKG_BUILD_DIR)/xt_cgroup.$(LINUX_KMOD_SUFFIX)
endef

include $(INCLUDE_DIR)/kernel-defaults.mk

define Build/Prepare
	$(call Build/Prepare/Default)
	$(CP) $(LINUX_DIR)/net/netfilter/xt_cgroup.c $(PKG_BUILD_DIR)/xt_cgroup.c
endef

define Build/Compile
	+$(MAKE) $(PKG_JOBS) -C "$(LINUX_DIR)" \
        CROSS_COMPILE="$(TARGET_CROSS)" \
        ARCH="$(LINUX_KARCH)" \
        SUBDIRS="$(PKG_BUILD_DIR)" \
        EXTRA_CFLAGS="$(BUILDFLAGS)" \
        modules
	$(call Build/Compile/Default)
endef

$(eval $(call BuildPackage,iptables-mod-cgroup))
$(eval $(call KernelPackage,ipt-cgroup))
