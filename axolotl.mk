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

# Build super partition
PRODUCT_BUILD_SUPER_PARTITION := true

# Widevine
PRODUCT_PACKAGES += \
    android.hardware.drm@1.4-service.widevine \

PRODUCT_PACKAGES += \
    libwvdrmengine \
    libwvhidl \
