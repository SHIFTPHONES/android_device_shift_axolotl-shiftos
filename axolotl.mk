#
# Copyright (C) 2022 SHIFT GmbH
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from full device.
$(call inherit-product, device/shift/axolotl/full_axolotl.mk)

# Inherit some common SHIFT stuff.
$(call inherit-product, vendor/shiftos/config/common_full.mk)

# Override product name for SHIFT.
PRODUCT_NAME := axolotl

#############################################################

PRODUCT_ENFORCE_ARTIFACT_PATH_REQUIREMENTS := true

# APEX
PRODUCT_COMPRESSED_APEX := true
MAINLINE_COMPRESS_APEX_ALL := $(PRODUCT_COMPRESSED_APEX)

# Automation/ATS
PRODUCT_PACKAGES += \
    automation_setup \

# Build super partition
PRODUCT_BUILD_SUPER_PARTITION := true

# Charger
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/charger/images/battery_fail.png:$(TARGET_COPY_OUT_PRODUCT)/etc/res/images/charger/battery_fail.png \
    $(LOCAL_PATH)/charger/images/battery_fail.png:$(TARGET_COPY_OUT_VENDOR)/etc/res/images/charger/battery_fail.png \
    $(LOCAL_PATH)/charger/images/battery_scale.png:$(TARGET_COPY_OUT_PRODUCT)/etc/res/images/charger/battery_scale.png \
    $(LOCAL_PATH)/charger/images/battery_scale.png:$(TARGET_COPY_OUT_VENDOR)/etc/res/images/charger/battery_scale.png \
    $(LOCAL_PATH)/charger/images/main_font.png:$(TARGET_COPY_OUT_PRODUCT)/etc/res/images/charger/main_font.png \
    $(LOCAL_PATH)/charger/images/main_font.png:$(TARGET_COPY_OUT_VENDOR)/etc/res/images/charger/main_font.png \

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/charger/values/animation.txt:$(TARGET_COPY_OUT_PRODUCT)/etc/res/values/charger/animation.txt \
    $(LOCAL_PATH)/charger/values/animation.txt:$(TARGET_COPY_OUT_VENDOR)/etc/res/values/charger/animation.txt \

# DRM - Widevine
#ifeq ($(WITH_GMS_MAINLINE),true)
include vendor/widevine/service.mk
#endif
