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

ifeq ($(WITH_AUTOMATION_USERDATA),true)
PRODUCT_PACKAGES += automation_trigger
endif

# Build super partition
PRODUCT_BUILD_SUPER_PARTITION := true

# DRM - Widevine
#ifeq ($(WITH_GMS_MAINLINE),true)
include vendor/widevine/service.mk
#endif
