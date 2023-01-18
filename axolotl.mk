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

# GMS
ifneq ($(WITH_64_BIT_ONLY),true)
GMS_MAKEFILE := gms_eea_v2_type4c.mk
else
GMS_MAKEFILE := gms_eea_v2_type4c_64bit_only.mk
endif
#MAINLINE_MODULES_MAKEFILE := mainline_modules.mk

#############################################################

PRODUCT_ENFORCE_ARTIFACT_PATH_REQUIREMENTS := true

# APEX
PRODUCT_COMPRESSED_APEX := true
MAINLINE_COMPRESS_APEX_ALL := $(PRODUCT_COMPRESSED_APEX)

# Automation/ATS
PRODUCT_PACKAGES += \
    automation_setup \

ifeq ($(WITH_AUTOMATION_USERDATA),true)
PRODUCT_PACKAGES += automation_trigger
endif

# Build super partition
PRODUCT_BUILD_SUPER_PARTITION := true

# Widevine
PRODUCT_PACKAGES += \
    android.hardware.drm@1.3-service.widevine \

PRODUCT_PACKAGES += \
    libwvdrmengine \
    libwvhidl \
