#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# A/B
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl \
    android.hardware.boot@1.2-impl.recovery \
    android.hardware.boot@1.2-service

PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=ext4 \
    POSTINSTALL_OPTIONAL_vendor=true

PRODUCT_PACKAGES += \
    checkpoint_gc \
    otapreopt_script

# API levels
PRODUCT_SHIPPING_API_LEVEL := 30

# ConfigStore
PRODUCT_PACKAGES += \
    android.hardware.configstore@1.1-service \
    disable_configstore

# fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock \
    fastbootd

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-service

# Overlays
PRODUCT_ENFORCE_RRO_TARGETS := *
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += $(LOCAL_PATH)/overlay

#VoLTE
PRODUCT_PACKAGES += \
    ImsService \
    mediatek-telephony-base \
    mediatek-telephony-common \
    mediatek-common \
    mediatek-framework \
    mediatek-ims-common \
    mediatek-ims-base \
    mediatek-telecom-common \
    mediatek-ims-extension-plugin \
    mediatek-ims-legacy \
    mediatek-services

PRODUCT_BOOT_JARS_EXTRA += \
    mediatek-telephony-base \
    mediatek-telephony-common \
    mediatek-common \
    mediatek-framework \
    mediatek-ims-common \
    mediatek-ims-base \
    mediatek-telecom-common \
    mediatek-ims-extension-plugin \
    mediatek-services

# Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Product characteristics
PRODUCT_CHARACTERISTICS := default

# Rootdir
PRODUCT_PACKAGES += \
    fmvolume.sh \
    init.insmod.sh \
    tinymix

PRODUCT_PACKAGES += \
    fstab.mt6739 \
    fstab.mt6739.init \
    fstab.enableswap.init \
    fstab.enableswap \
    factory_init.connectivity.common.rc \
    factory_init.connectivity.rc \
    factory_init.project.rc \
    factory_init.rc \
    init.aee.rc \
    init.ago.rc \
    init.connectivity.common.rc \
    init.connectivity.rc \
    init.modem.rc \
    init.mt6739.rc \
    init.mt6739.usb.rc \
    init.project.rc \
    init.sensor_1_0.rc \
    init_connectivity.rc \
    meta_init.connectivity.common.rc \
    meta_init.connectivity.rc \
    meta_init.modem.rc \
    meta_init.project.rc \
    meta_init.rc \
    meta_init.vendor.rc \
    multi_init.rc \
    init.recovery.mt6739.rc

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Boot animation
TARGET_SCREEN_WIDTH := 480
TARGET_SCREEN_HEIGHT := 960

# Inherit the proprietary files
$(call inherit-product, vendor/fise/KL605/KL605-vendor.mk)


#VoLTE
PRODUCT_PACKAGES += \
    ImsNet

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/imsnet/privapp-permissions-imsnet.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-imsnet.xml

# MTK uses mtkfusionrild, not AOSP reference rild
PRODUCT_PACKAGES := $(filter-out rild,$(PRODUCT_PACKAGES))
