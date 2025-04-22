#
# Copyright (C) 2022-2023 SHIFT GmbH
#
# SPDX-License-Identifier: Apache-2.0
#

# Include common SHIFT device BoardConfig
include device/shift/common/BoardConfig.mk

### AVB

# Enable AVB 2.0
BOARD_AVB_ENABLE := true

PRIVATE_KEY_PATH := vendor/shiftos/private/keys/avb/axolotl-4096.pem

# If private key does not exist, fallback to testkey
ifeq ($(wildcard $(PRIVATE_KEY_PATH)),)
    PRIVATE_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
endif

# AVB - vbmeta
BOARD_AVB_ALGORITHM := SHA256_RSA4096
BOARD_AVB_KEY_PATH  := $(PRIVATE_KEY_PATH)

# AVB - vbmeta_system
BOARD_AVB_VBMETA_SYSTEM := system system_ext
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := $(PRIVATE_KEY_PATH)
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA4096
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 11

# AVB - vbmeta_vendor
BOARD_AVB_VBMETA_VENDOR := odm vendor
BOARD_AVB_VBMETA_VENDOR_KEY_PATH := $(PRIVATE_KEY_PATH)
BOARD_AVB_VBMETA_VENDOR_ALGORITHM := SHA256_RSA4096
BOARD_AVB_VBMETA_VENDOR_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_VENDOR_ROLLBACK_INDEX_LOCATION := 12

# AVB - clear any set flags
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS :=

BOARD_AVB_PRODUCT_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256
BOARD_AVB_SYSTEM_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256
BOARD_AVB_SYSTEM_EXT_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256

BOARD_AVB_ODM_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256
BOARD_AVB_VENDOR_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256

#############################################################

# DRM
TARGET_ENABLE_MEDIADRM_64 := true

# Kernel
ifeq ($(TARGET_BUILD_VARIANT),eng)
    TARGET_KERNEL_CONFIG := axolotl_eng_defconfig
else
    ifeq ($(TARGET_BUILD_VARIANT),userdebug)
        TARGET_KERNEL_CONFIG := axolotl_userdebug_defconfig
        TARGET_KERNEL_CONFIG += vendor/debugfs.config
    else
        TARGET_KERNEL_CONFIG := axolotl_user_defconfig
        TARGET_KERNEL_CONFIG += vendor/debugfs.config
    endif
endif

# Enable console for non-user builds
ifneq ($(TARGET_BUILD_VARIANT),user)
    BOARD_KERNEL_CMDLINE += console=ttyMSM0,115200n8 earlycon=msm_geni_serial,0xA84000
endif

# Security patch level
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)

# Super
BOARD_BUILD_SUPER_IMAGE_BY_DEFAULT := true
