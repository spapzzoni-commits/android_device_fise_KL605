#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from KL605 device
$(call inherit-product, device/fise/KL605/device.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

PRODUCT_DEVICE := KL605
PRODUCT_NAME := lineage_KL605
PRODUCT_BRAND := KLIPAD
PRODUCT_MODEL := KL605
PRODUCT_MANUFACTURER := fise

PRODUCT_GMS_CLIENTID_BASE := android-fise

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="sys_mssi_32_ago_ww-user 12 SP1A.210812.016 mp1V14151P3 release-keys" \
    BuildFingerprint=KLIPAD/KL605_EEA/KL605:12/SP1A.210812.016/1669285084:user/release-keys
