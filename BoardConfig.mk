#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/fise/KL605

# A/B
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    boot \
    vbmeta_vendor \
    vendor \
    system \
    vbmeta_system \
    product
BOARD_USES_RECOVERY_AS_BOOT := true

# Architecture
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a53

TARGET_USES_64_BIT_BINDER := true

# APEX
OVERRIDE_TARGET_FLATTEN_APEX := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := KL605
TARGET_NO_BOOTLOADER := true

# Display
TARGET_SCREEN_DENSITY := 175

# Kernel
BOARD_BOOT_HEADER_VERSION := 2
BOARD_KERNEL_BASE := 0x40000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_RAMDISK_OFFSET := 0x05000000
BOARD_SECOND_OFFSET := 0xc0000000
BOARD_KERNEL_TAGS_OFFSET := 0x04000000
BOARD_DTB_OFFSET := 0x04000000

BOARD_KERNEL_CMDLINE := bootopt=64S3,32S1,32S1 androidboot.vbmeta.device_state=unlocked

BOARD_MKBOOTIMG_ARGS := --base $(BOARD_KERNEL_BASE)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE)
BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTIMG_ARGS += --second_offset $(BOARD_SECOND_OFFSET)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_KERNEL_SEPARATED_DTBO := true
TARGET_KERNEL_CONFIG := KL605_defconfig
TARGET_KERNEL_SOURCE := kernel/fise/KL605

# Kernel - prebuilt
TARGET_FORCE_PREBUILT_KERNEL := true
ifeq ($(TARGET_FORCE_PREBUILT_KERNEL),true)
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilts/kernel
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilts/dtb.img
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)
BOARD_INCLUDE_DTB_IN_BOOTIMG := 
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilts/dtbo.img
BOARD_KERNEL_SEPARATED_DTBO := 
endif

# Partitions
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE := 25165824
BOARD_DTBOIMG_PARTITION_SIZE := 8388608
BOARD_SUPER_PARTITION_SIZE := 2684354560
BOARD_SUPER_PARTITION_GROUPS := fise_dynamic_partitions
BOARD_FISE_DYNAMIC_PARTITIONS_PARTITION_LIST := \
    product \
    vendor \
    system
BOARD_FISE_DYNAMIC_PARTITIONS_SIZE := 2682257408
BOARD_SYSTEMIMAGE_PARTITION_RESERVED_SIZE := 482344960
BOARD_PRODUCTIMAGE_PARTITION_RESERVED_SIZE := 629145600

BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4

BOARD_USES_METADATA_PARTITION := true
BOARD_ROOT_EXTRA_FOLDERS += metadata

# Platform
TARGET_BOARD_PLATFORM := mt6739

# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop
TARGET_PRODUCT_PROP += $(DEVICE_PATH)/product.prop
#TARGET_ODM_PROP += $(DEVICE_PATH)/odm.prop
#TARGET_ODM_DLKM_PROP += $(DEVICE_PATH)/odm_dlkm.prop
#TARGET_VENDOR_DLKM_PROP += $(DEVICE_PATH)/vendor_dlkm.prop

TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM_EXT := system/system_ext
TARGET_COPY_OUT_VENDOR := vendor

#dévermissage
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_PREBUILT_ELF_FILES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

# Recovery
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.mt6739
#TARGET_RECOVERY_PIXEL_FORMAT := BGRA_8888
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Security patch level
VENDOR_SECURITY_PATCH := 2022-10-05

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1

BOARD_AVB_VBMETA_SYSTEM := product system
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := 1
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 2

BOARD_AVB_VBMETA_VENDOR := vendor
BOARD_AVB_VBMETA_VENDOR_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_VENDOR_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_VENDOR_ROLLBACK_INDEX := 1
BOARD_AVB_VBMETA_VENDOR_ROLLBACK_INDEX_LOCATION := 3

BOARD_AVB_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_BOOT_ALGORITHM := SHA256_RSA2048
BOARD_AVB_BOOT_ROLLBACK_INDEX := 1
BOARD_AVB_BOOT_ROLLBACK_INDEX_LOCATION := 4

# VINTF
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/manifest.xml \
	$(DEVICE_PATH)/vintf/manifest/gnss@2.1-service.xml \
	$(DEVICE_PATH)/vintf/manifest/android.hardware.wifi.hostapd.xml \
	$(DEVICE_PATH)/vintf/manifest/lights-mtk-default.xml \
	$(DEVICE_PATH)/vintf/manifest/gnss-default.xml \
	$(DEVICE_PATH)/vintf/manifest/manifest_android.hardware.drm@1.4-service.widevine.xml \
	$(DEVICE_PATH)/vintf/manifest/android.hardware.wifi.supplicant.xml \
	$(DEVICE_PATH)/vintf/manifest/manifest_android.hardware.drm@1.4-service.clearkey.xml \
	$(DEVICE_PATH)/vintf/manifest/lbs_hidl_service@1.0.xml \
	$(DEVICE_PATH)/vintf/manifest/power-default.xml \
	$(DEVICE_PATH)/vintf/manifest/manifest_media_c2_V1_2_default.xml \
	$(DEVICE_PATH)/vintf/manifest/android.hardware.boot@1.2.xml \
	$(DEVICE_PATH)/vintf/manifest/android.hardware.usb@1.2-service-mediatekv2.xml \
	$(DEVICE_PATH)/vintf/manifest/android.hardware.wifi@1.0-service.xml \
	$(DEVICE_PATH)/vintf/manifest/vibrator-mtk-default.xml \
	$(DEVICE_PATH)/vintf/manifest/android.hardware.health@2.1.xml \
	$(DEVICE_PATH)/vintf/manifest/manifest_hwcomposer.xml

DEVICE_MATRIX_FILE += \
	$(DEVICE_PATH)/vintf/compatibility_matrix.xml

DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += \
	$(DEVICE_PATH)/vintf/framework_compatibility_matrix.xml \
	$(DEVICE_PATH)/vintf/compatibility_matrix.device.xml

ODM_MANIFEST_FILES += \
	$(DEVICE_PATH)/vintf/odm/manifest_dsds.xml \
	$(DEVICE_PATH)/vintf/odm/manifest_qsqs.xml \
	$(DEVICE_PATH)/vintf/odm/manifest_ss.xml \
	$(DEVICE_PATH)/vintf/odm/manifest_tsts.xml

# Inherit the proprietary files
include vendor/fise/KL605/BoardConfigVendor.mk

# Sepolicy
include device/mediatek/sepolicy_vndr/SEPolicy.mk
BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/vendor
SELINUX_IGNORE_NEVERALLOWS := true
