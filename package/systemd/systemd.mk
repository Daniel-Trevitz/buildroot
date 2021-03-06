################################################################################
#
# systemd
#
################################################################################

SYSTEMD_VERSION = 245.4
SYSTEMD_SITE = $(call github,systemd,systemd-stable,v$(SYSTEMD_VERSION))
SYSTEMD_LICENSE = LGPL-2.1+, GPL-2.0+ (udev), Public Domain (few source files, see README), BSD-3-Clause (tools/chromiumos)
SYSTEMD_LICENSE_FILES = LICENSE.GPL2 LICENSE.LGPL2.1 README tools/chromiumos/LICENSE
SYSTEMD_INSTALL_STAGING = YES
SYSTEMD_DEPENDENCIES = \
	$(BR2_COREUTILS_HOST_DEPENDENCY) \
	$(if $(BR2_PACKAGE_BASH_COMPLETION),bash-completion) \
	host-gperf \
	kmod \
	libcap \
	util-linux \
	$(TARGET_NLS_DEPENDENCIES)

SYSTEMD_PROVIDES = udev

SYSTEMD_CONF_OPTS += \
	-Drootlibdir='/usr/lib' \
	-Dblkid=true \
	-Dman=false \
	-Dima=false \
	-Dldconfig=false \
	-Ddefault-dnssec=no \
	-Ddefault-hierarchy=hybrid \
	-Dtests=false \
	-Dsplit-bin=true \
	-Dsplit-usr=false \
	-Dsystem-uid-max=999 \
	-Dsystem-gid-max=999 \
	-Dtelinit-path=$(TARGET_DIR)/sbin/telinit \
	-Dkmod-path=/usr/bin/kmod \
	-Dkexec-path=/usr/sbin/kexec \
	-Dsulogin-path=/usr/sbin/sulogin \
	-Dmount-path=/usr/bin/mount \
	-Dumount-path=/usr/bin/umount \
	-Dnobody-group=nogroup \
	-Didn=true \
	-Dhomed=false \
	-Dnss-systemd=true

ifeq ($(BR2_PACKAGE_ACL),y)
SYSTEMD_DEPENDENCIES += acl
SYSTEMD_CONF_OPTS += -Dacl=true
else
SYSTEMD_CONF_OPTS += -Dacl=false
endif

ifeq ($(BR2_PACKAGE_AUDIT),y)
SYSTEMD_DEPENDENCIES += audit
SYSTEMD_CONF_OPTS += -Daudit=true
else
SYSTEMD_CONF_OPTS += -Daudit=false
endif

ifeq ($(BR2_PACKAGE_CRYPTSETUP),y)
SYSTEMD_DEPENDENCIES += cryptsetup
SYSTEMD_CONF_OPTS += -Dlibcryptsetup=true
else
SYSTEMD_CONF_OPTS += -Dlibcryptsetup=false
endif

ifeq ($(BR2_PACKAGE_ELFUTILS),y)
SYSTEMD_DEPENDENCIES += elfutils
SYSTEMD_CONF_OPTS += -Delfutils=true
else
SYSTEMD_CONF_OPTS += -Delfutils=false
endif

ifeq ($(BR2_PACKAGE_IPTABLES),y)
SYSTEMD_DEPENDENCIES += iptables
SYSTEMD_CONF_OPTS += -Dlibiptc=true
else
SYSTEMD_CONF_OPTS += -Dlibiptc=false
endif

# Both options can't be selected at the same time so prefer libidn2
ifeq ($(BR2_PACKAGE_LIBIDN2),y)
SYSTEMD_DEPENDENCIES += libidn2
SYSTEMD_CONF_OPTS += -Dlibidn2=true -Dlibidn=false
else ifeq ($(BR2_PACKAGE_LIBIDN),y)
SYSTEMD_DEPENDENCIES += libidn
SYSTEMD_CONF_OPTS += -Dlibidn=true -Dlibidn2=false
else
SYSTEMD_CONF_OPTS += -Dlibidn=false -Dlibidn2=false
endif

ifeq ($(BR2_PACKAGE_LIBSECCOMP),y)
SYSTEMD_DEPENDENCIES += libseccomp
SYSTEMD_CONF_OPTS += -Dseccomp=true
else
SYSTEMD_CONF_OPTS += -Dseccomp=false
endif

ifeq ($(BR2_PACKAGE_LIBXKBCOMMON),y)
SYSTEMD_DEPENDENCIES += libxkbcommon
SYSTEMD_CONF_OPTS += -Dxkbcommon=true
else
SYSTEMD_CONF_OPTS += -Dxkbcommon=false
endif

ifeq ($(BR2_PACKAGE_BZIP2),y)
SYSTEMD_DEPENDENCIES += bzip2
SYSTEMD_CONF_OPTS += -Dbzip2=true
else
SYSTEMD_CONF_OPTS += -Dbzip2=false
endif

ifeq ($(BR2_PACKAGE_LZ4),y)
SYSTEMD_DEPENDENCIES += lz4
SYSTEMD_CONF_OPTS += -Dlz4=true
else
SYSTEMD_CONF_OPTS += -Dlz4=false
endif

ifeq ($(BR2_PACKAGE_LINUX_PAM),y)
SYSTEMD_DEPENDENCIES += linux-pam
SYSTEMD_CONF_OPTS += -Dpam=true
else
SYSTEMD_CONF_OPTS += -Dpam=false
endif

ifeq ($(BR2_PACKAGE_VALGRIND),y)
SYSTEMD_DEPENDENCIES += valgrind
SYSTEMD_CONF_OPTS += -Dvalgrind=true
else
SYSTEMD_CONF_OPTS += -Dvalgrind=false
endif

ifeq ($(BR2_PACKAGE_XZ),y)
SYSTEMD_DEPENDENCIES += xz
SYSTEMD_CONF_OPTS += -Dxz=true
else
SYSTEMD_CONF_OPTS += -Dxz=false
endif

ifeq ($(BR2_PACKAGE_ZLIB),y)
SYSTEMD_DEPENDENCIES += zlib
SYSTEMD_CONF_OPTS += -Dzlib=true
else
SYSTEMD_CONF_OPTS += -Dzlib=false
endif

ifeq ($(BR2_PACKAGE_LIBCURL),y)
SYSTEMD_DEPENDENCIES += libcurl
SYSTEMD_CONF_OPTS += -Dlibcurl=true
else
SYSTEMD_CONF_OPTS += -Dlibcurl=false
endif

ifeq ($(BR2_PACKAGE_LIBGCRYPT),y)
SYSTEMD_DEPENDENCIES += libgcrypt
SYSTEMD_CONF_OPTS += -Dgcrypt=true
else
SYSTEMD_CONF_OPTS += -Dgcrypt=false
endif

ifeq ($(BR2_PACKAGE_PCRE2),y)
SYSTEMD_DEPENDENCIES += pcre2
SYSTEMD_CONF_OPTS += -Dpcre2=true
else
SYSTEMD_CONF_OPTS += -Dpcre2=false
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_JOURNAL_GATEWAY),y)
SYSTEMD_DEPENDENCIES += libmicrohttpd
SYSTEMD_CONF_OPTS += -Dmicrohttpd=true
ifeq ($(BR2_PACKAGE_LIBQRENCODE),y)
SYSTEMD_CONF_OPTS += -Dqrencode=true
SYSTEMD_DEPENDENCIES += libqrencode
else
SYSTEMD_CONF_OPTS += -Dqrencode=false
endif
else
SYSTEMD_CONF_OPTS += -Dmicrohttpd=false -Dqrencode=false
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_JOURNAL_REMOTE),y)
SYSTEMD_CONF_OPTS += -Dremote=true
else
SYSTEMD_CONF_OPTS += -Dremote=false
endif

ifeq ($(BR2_PACKAGE_LIBSELINUX),y)
SYSTEMD_DEPENDENCIES += libselinux
SYSTEMD_CONF_OPTS += -Dselinux=true
else
SYSTEMD_CONF_OPTS += -Dselinux=false
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_HWDB),y)
SYSTEMD_CONF_OPTS += -Dhwdb=true
define SYSTEMD_BUILD_HWDB
	$(HOST_DIR)/bin/udevadm hwdb --update --root $(TARGET_DIR)
endef
SYSTEMD_TARGET_FINALIZE_HOOKS += SYSTEMD_BUILD_HWDB
define SYSTEMD_RM_HWDB_SRV
	rm -rf $(TARGET_DIR)/$(HOST_EUDEV_SYSCONFDIR)/udev/hwdb.d/
endef
SYSTEMD_ROOTFS_PRE_CMD_HOOKS += SYSTEMD_RM_HWDB_SRV
else
SYSTEMD_CONF_OPTS += -Dhwdb=false
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_BINFMT),y)
SYSTEMD_CONF_OPTS += -Dbinfmt=true
else
SYSTEMD_CONF_OPTS += -Dbinfmt=false
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_VCONSOLE),y)
SYSTEMD_CONF_OPTS += -Dvconsole=true
else
SYSTEMD_CONF_OPTS += -Dvconsole=false
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_QUOTACHECK),y)
SYSTEMD_CONF_OPTS += -Dquotacheck=true
else
SYSTEMD_CONF_OPTS += -Dquotacheck=false
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_TMPFILES),y)
SYSTEMD_CONF_OPTS += -Dtmpfiles=true
else
SYSTEMD_CONF_OPTS += -Dtmpfiles=false
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_SYSUSERS),y)
SYSTEMD_CONF_OPTS += -Dsysusers=true
else
SYSTEMD_CONF_OPTS += -Dsysusers=false
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_FIRSTBOOT),y)
SYSTEMD_CONF_OPTS += -Dfirstboot=true
else
SYSTEMD_CONF_OPTS += -Dfirstboot=false
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_RANDOMSEED),y)
SYSTEMD_CONF_OPTS += -Drandomseed=true
else
SYSTEMD_CONF_OPTS += -Drandomseed=false
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_BACKLIGHT),y)
SYSTEMD_CONF_OPTS += -Dbacklight=true
else
SYSTEMD_CONF_OPTS += -Dbacklight=false
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_RFKILL),y)
SYSTEMD_CONF_OPTS += -Drfkill=true
else
SYSTEMD_CONF_OPTS += -Drfkill=false
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_LOGIND),y)
SYSTEMD_CONF_OPTS += -Dlogind=true
else
SYSTEMD_CONF_OPTS += -Dlogind=false
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_MACHINED),y)
SYSTEMD_CONF_OPTS += -Dmachined=true
else
SYSTEMD_CONF_OPTS += -Dmachined=false
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_IMPORTD),y)
SYSTEMD_CONF_OPTS += -Dimportd=true
else
SYSTEMD_CONF_OPTS += -Dimportd=false
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_HOSTNAMED),y)
SYSTEMD_CONF_OPTS += -Dhostnamed=true
else
SYSTEMD_CONF_OPTS += -Dhostnamed=false
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_MYHOSTNAME),y)
SYSTEMD_CONF_OPTS += -Dnss-myhostname=true
else
SYSTEMD_CONF_OPTS += -Dnss-myhostname=false
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_TIMEDATED),y)
SYSTEMD_CONF_OPTS += -Dtimedated=true
else
SYSTEMD_CONF_OPTS += -Dtimedated=false
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_LOCALED),y)
SYSTEMD_CONF_OPTS += -Dlocaled=true
else
SYSTEMD_CONF_OPTS += -Dlocaled=false
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_REPART),y)
SYSTEMD_CONF_OPTS += -Drepart=true
SYSTEMD_DEPENDENCIES += openssl
else
SYSTEMD_CONF_OPTS += -Drepart=false
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_USERDB),y)
SYSTEMD_CONF_OPTS += -Duserdb=true
else
SYSTEMD_CONF_OPTS += -Duserdb=false
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_COREDUMP),y)
SYSTEMD_CONF_OPTS += -Dcoredump=true
SYSTEMD_COREDUMP_USER = systemd-coredump -1 systemd-coredump -1 * /var/lib/systemd/coredump - - Core Dumper
else
SYSTEMD_CONF_OPTS += -Dcoredump=false
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_PSTORE),y)
SYSTEMD_CONF_OPTS += -Dpstore=true
else
SYSTEMD_CONF_OPTS += -Dpstore=false
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_POLKIT),y)
SYSTEMD_CONF_OPTS += -Dpolkit=true
SYSTEMD_DEPENDENCIES += polkit
else
SYSTEMD_CONF_OPTS += -Dpolkit=false
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_NETWORKD),y)
SYSTEMD_CONF_OPTS += -Dnetworkd=true
SYSTEMD_NETWORKD_USER = systemd-network -1 systemd-network -1 * - - - Network Manager
SYSTEMD_NETWORKD_DHCP_IFACE = $(call qstrip,$(BR2_SYSTEM_DHCP))
ifneq ($(SYSTEMD_NETWORKD_DHCP_IFACE),)
define SYSTEMD_INSTALL_NETWORK_CONFS
	sed s/SYSTEMD_NETWORKD_DHCP_IFACE/$(SYSTEMD_NETWORKD_DHCP_IFACE)/ \
		$(SYSTEMD_PKGDIR)/dhcp.network > \
		$(TARGET_DIR)/etc/systemd/network/$(SYSTEMD_NETWORKD_DHCP_IFACE).network
endef
endif
else
SYSTEMD_CONF_OPTS += -Dnetworkd=false
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_RESOLVED),y)
define SYSTEMD_INSTALL_RESOLVCONF_HOOK
	ln -sf ../run/systemd/resolve/resolv.conf \
		$(TARGET_DIR)/etc/resolv.conf
endef
SYSTEMD_CONF_OPTS += -Dresolve=true
SYSTEMD_RESOLVED_USER = systemd-resolve -1 systemd-resolve -1 * - - - Network Name Resolution Manager
else
SYSTEMD_CONF_OPTS += -Dresolve=false
endif

ifeq ($(BR2_PACKAGE_GNUTLS),y)
SYSTEMD_CONF_OPTS += -Ddns-over-tls=gnutls -Ddefault-dns-over-tls=opportunistic
SYSTEMD_DEPENDENCIES += gnutls
else ifeq ($(BR2_PACKAGE_OPENSSL),y)
SYSTEMD_CONF_OPTS += -Ddns-over-tls=openssl -Ddefault-dns-over-tls=opportunistic
SYSTEMD_DEPENDENCIES += openssl
else
SYSTEMD_CONF_OPTS += -Ddns-over-tls=false -Ddefault-dns-over-tls=no
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_TIMESYNCD),y)
SYSTEMD_CONF_OPTS += -Dtimesyncd=true
SYSTEMD_TIMESYNCD_USER = systemd-timesync -1 systemd-timesync -1 * - - - Network Time Synchronization
else
SYSTEMD_CONF_OPTS += -Dtimesyncd=false
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_SMACK_SUPPORT),y)
SYSTEMD_CONF_OPTS += -Dsmack=true
else
SYSTEMD_CONF_OPTS += -Dsmack=false
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_HIBERNATE),y)
SYSTEMD_CONF_OPTS += -Dhibernate=true
else
SYSTEMD_CONF_OPTS += -Dhibernate=false
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_BOOT),y)
SYSTEMD_INSTALL_IMAGES = YES
SYSTEMD_DEPENDENCIES += gnu-efi
SYSTEMD_CONF_OPTS += \
	-Defi=true \
	-Dgnu-efi=true \
	-Defi-cc=$(TARGET_CC) \
	-Defi-ld=$(TARGET_LD) \
	-Defi-libdir=$(STAGING_DIR)/usr/lib \
	-Defi-ldsdir=$(STAGING_DIR)/usr/lib \
	-Defi-includedir=$(STAGING_DIR)/usr/include/efi

SYSTEMD_BOOT_EFI_ARCH = $(call qstrip,$(BR2_PACKAGE_SYSTEMD_BOOT_EFI_ARCH))
define SYSTEMD_INSTALL_BOOT_FILES
	$(INSTALL) -D -m 0644 $(@D)/build/src/boot/efi/systemd-boot$(SYSTEMD_BOOT_EFI_ARCH).efi \
		$(BINARIES_DIR)/efi-part/EFI/BOOT/boot$(SYSTEMD_BOOT_EFI_ARCH).efi
	echo "boot$(SYSTEMD_BOOT_EFI_ARCH).efi" > \
		$(BINARIES_DIR)/efi-part/startup.nsh
	$(INSTALL) -D -m 0644 $(SYSTEMD_PKGDIR)/boot-files/loader.conf \
		$(BINARIES_DIR)/efi-part/loader/loader.conf
	$(INSTALL) -D -m 0644 $(SYSTEMD_PKGDIR)/boot-files/buildroot.conf \
		$(BINARIES_DIR)/efi-part/loader/entries/buildroot.conf
endef

else
SYSTEMD_CONF_OPTS += -Defi=false -Dgnu-efi=false
endif # BR2_PACKAGE_SYSTEMD_BOOT == y

SYSTEMD_FALLBACK_HOSTNAME = $(call qstrip,$(BR2_TARGET_GENERIC_HOSTNAME))
ifneq ($(SYSTEMD_FALLBACK_HOSTNAME),)
SYSTEMD_CONF_OPTS += -Dfallback-hostname=$(SYSTEMD_FALLBACK_HOSTNAME)
endif

define SYSTEMD_INSTALL_INIT_HOOK
	ln -fs multi-user.target \
		$(TARGET_DIR)/usr/lib/systemd/system/default.target
endef

define SYSTEMD_INSTALL_MACHINEID_HOOK
	touch $(TARGET_DIR)/etc/machine-id
endef

SYSTEMD_POST_INSTALL_TARGET_HOOKS += \
	SYSTEMD_INSTALL_INIT_HOOK \
	SYSTEMD_INSTALL_MACHINEID_HOOK \
	SYSTEMD_INSTALL_RESOLVCONF_HOOK

define SYSTEMD_INSTALL_IMAGES_CMDS
	$(SYSTEMD_INSTALL_BOOT_FILES)
endef

define SYSTEMD_USERS
	- - input -1 * - - - Input device group
	- - systemd-journal -1 * - - - Journal
	- - render -1 * - - - DRI rendering nodes
	- - kvm -1 * - - - kvm nodes
	systemd-bus-proxy -1 systemd-bus-proxy -1 * - - - Proxy D-Bus messages to/from a bus
	systemd-journal-gateway -1 systemd-journal-gateway -1 * /var/log/journal - - Journal Gateway
	systemd-journal-remote -1 systemd-journal-remote -1 * /var/log/journal/remote - - Journal Remote
	systemd-journal-upload -1 systemd-journal-upload -1 * - - - Journal Upload
	$(SYSTEMD_COREDUMP_USER)
	$(SYSTEMD_NETWORKD_USER)
	$(SYSTEMD_RESOLVED_USER)
	$(SYSTEMD_TIMESYNCD_USER)
endef

ifneq ($(call qstrip,$(BR2_TARGET_GENERIC_GETTY_PORT)),)
# systemd needs getty.service for VTs and serial-getty.service for serial ttys
# note that console-getty.service should be used on /dev/console as it should not have dependencies
# also patch the file to use the correct baud-rate, the default baudrate is 115200 so look for that
#
# systemd defaults to only have getty@tty.service enabled
# * DefaultInstance=tty1 in getty@service
# * no DefaultInstance in serial-getty@.service
# * WantedBy=getty.target in console-getty.service
# * console-getty is not enabled because of 90-systemd.preset
# We want "systemctl preset-all" to do the right thing, even when run on the target after boot
# * remove the default instance of getty@.service via a drop-in in /usr/lib
# * set a new DefaultInstance for getty@.service instead, if needed
# * set a new DefaultInstance for serial-getty@.service, if needed
# * override the systemd-provided preset for console-getty.service if needed
define SYSTEMD_INSTALL_SERVICE_TTY
	mkdir $(TARGET_DIR)/usr/lib/systemd/system/getty@.service.d; \
	printf '[Install]\nDefaultInstance=\n' \
		>$(TARGET_DIR)/usr/lib/systemd/system/getty@.service.d/buildroot-console.conf; \
	if [ $(BR2_TARGET_GENERIC_GETTY_PORT) = "console" ]; \
	then \
		TARGET="console-getty.service"; \
		printf 'enable console-getty.service\n' \
			>$(TARGET_DIR)/usr/lib/systemd/system-preset/81-buildroot-tty.preset; \
	elif echo $(BR2_TARGET_GENERIC_GETTY_PORT) | egrep -q 'tty[0-9]*$$'; \
	then \
		TARGET="getty@.service"; \
		printf '[Install]\nDefaultInstance=%s\n' \
			$(call qstrip,$(BR2_TARGET_GENERIC_GETTY_PORT)) \
			>$(TARGET_DIR)/usr/lib/systemd/system/getty@.service.d/buildroot-console.conf; \
	else \
		TARGET="serial-getty@.service"; \
		mkdir $(TARGET_DIR)/usr/lib/systemd/system/serial-getty@.service.d;\
		printf '[Install]\nDefaultInstance=%s\n' \
			$(call qstrip,$(BR2_TARGET_GENERIC_GETTY_PORT)) \
			>$(TARGET_DIR)/usr/lib/systemd/system/serial-getty@.service.d/buildroot-console.conf;\
	fi; \
	if [ $(call qstrip,$(BR2_TARGET_GENERIC_GETTY_BAUDRATE)) -gt 0 ] ; \
	then \
		$(SED) 's,115200,$(BR2_TARGET_GENERIC_GETTY_BAUDRATE),' $(TARGET_DIR)/lib/systemd/system/$${TARGET}; \
	fi
endef
endif

define SYSTEMD_INSTALL_PRESET
	$(INSTALL) -D -m 644 $(SYSTEMD_PKGDIR)/80-buildroot.preset $(TARGET_DIR)/usr/lib/systemd/system-preset/80-buildroot.preset
endef

define SYSTEMD_INSTALL_INIT_SYSTEMD
	$(SYSTEMD_INSTALL_PRESET)
	$(SYSTEMD_INSTALL_SERVICE_TTY)
	$(SYSTEMD_INSTALL_NETWORK_CONFS)
endef

define SYSTEMD_PRESET_ALL
	$(HOST_DIR)/bin/systemctl --root=$(TARGET_DIR) preset-all
endef
SYSTEMD_TARGET_FINALIZE_HOOKS += SYSTEMD_PRESET_ALL

SYSTEMD_CONF_ENV = $(HOST_UTF8_LOCALE_ENV)
SYSTEMD_NINJA_ENV = $(HOST_UTF8_LOCALE_ENV)

# We need a very minimal host variant, so we disable as much as possible.
HOST_SYSTEMD_CONF_OPTS = \
	-Dsplit-bin=true \
	-Dsplit-usr=false \
	--prefix=/usr \
	--libdir=lib \
	--sysconfdir=/etc \
	--localstatedir=/var \
	-Dutmp=false \
	-Dhibernate=false \
	-Dldconfig=false \
	-Dresolve=false \
	-Defi=false \
	-Dtpm=false \
	-Denvironment-d=false \
	-Dbinfmt=false \
	-Drepart=false \
	-Dcoredump=false \
	-Dpstore=false \
	-Dlogind=false \
	-Dhostnamed=false \
	-Dlocaled=false \
	-Dmachined=false \
	-Dportabled=false \
	-Duserdb=false \
	-Dhomed=false \
	-Dnetworkd=false \
	-Dtimedated=false \
	-Dtimesyncd=false \
	-Dremote=false \
	-Dcreate-log-dirs=false \
	-Dnss-myhostname=false \
	-Dnss-mymachines=false \
	-Dnss-resolve=false \
	-Dnss-systemd=false \
	-Dfirstboot=false \
	-Drandomseed=false \
	-Dbacklight=false \
	-Dvconsole=false \
	-Dquotacheck=false \
	-Dsysusers=false \
	-Dtmpfiles=false \
	-Dimportd=false \
	-Dhwdb=false \
	-Drfkill=false \
	-Dman=false \
	-Dhtml=false \
	-Dsmack=false \
	-Dpolkit=false \
	-Dblkid=false \
	-Didn=false \
	-Dadm-group=false \
	-Dwheel-group=false \
	-Dzlib=false \
	-Dgshadow=false \
	-Dima=false \
	-Dtests=false \
	-Dglib=false \
	-Dacl=false \
	-Dsysvinit-path=''

HOST_SYSTEMD_DEPENDENCIES = \
	$(BR2_COREUTILS_HOST_DEPENDENCY) \
	host-util-linux \
	host-patchelf \
	host-libcap \
	host-gperf

# Fix RPATH After installation
# * systemd provides a install_rpath instruction to meson because the binaries
#   need to link with libsystemd which is not in a standard path
# * meson can only replace the RPATH, not append to it
# * the original rpath is thus lost.
# * the original path had been tweaked by buildroot via LDFLAGS to add
#   $(HOST_DIR)/lib
# * thus re-tweak rpath after the installation for all binaries that need it
HOST_SYSTEMD_HOST_TOOLS = \
	systemd-analyze \
	systemd-machine-id-setup \
	systemd-mount \
	systemd-nspawn \
	systemctl \
	udevadm

HOST_SYSTEMD_NINJA_ENV = DESTDIR=$(HOST_DIR)

define HOST_SYSTEMD_FIX_RPATH
	$(foreach f,$(HOST_SYSTEMD_HOST_TOOLS), \
		$(HOST_DIR)/bin/patchelf --set-rpath $(HOST_DIR)/lib:$(HOST_DIR)/lib/systemd $(HOST_DIR)/bin/$(f)
	)
endef
HOST_SYSTEMD_POST_INSTALL_HOOKS += HOST_SYSTEMD_FIX_RPATH

$(eval $(meson-package))
$(eval $(host-meson-package))
