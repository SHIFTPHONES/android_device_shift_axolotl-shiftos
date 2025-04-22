#
# Copyright (C) SHIFT GmbH
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from full device.
$(call inherit-product, device/shift/axolotl/full_axolotl.mk)

# Inherit from common device.
$(call inherit-product, device/shift/common/common.mk)

# Inherit some common SHIFT stuff.
$(call inherit-product, vendor/shiftos/config/common_full.mk)

# Override product name for SHIFT.
PRODUCT_NAME := axolotl

#############################################################

# Enforce native interfaces of product partition as VNDK
#PRODUCT_PRODUCT_VNDK_VERSION := current

# Enforce java interfaces of product partition
PRODUCT_ENFORCE_PRODUCT_PARTITION_INTERFACE := false

#############################################################

# APEX
PRODUCT_COMPRESSED_APEX := true
MAINLINE_COMPRESS_APEX_ALL := $(PRODUCT_COMPRESSED_APEX)

# DRM
PRODUCT_PACKAGES += \
    drmserver \
    libdrmframework \
    libdrmframework_jni \

PRODUCT_PROPERTY_OVERRIDES += \
    drm.service.enabled=true \
    media.mediadrmservice.enable=true \

# DRM - Widevine
#include vendor/widevine/service.mk

# Overlays
PRODUCT_PACKAGES += AxolotlFrameworksOverlay
