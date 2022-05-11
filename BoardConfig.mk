#
# Copyright (C) 2022 SHIFT GmbH
#
# SPDX-License-Identifier: Apache-2.0
#

# Kernel
ifeq ($(TARGET_BUILD_VARIANT),eng)
    TARGET_KERNEL_CONFIG := axolotl_eng_defconfig
else
    ifeq ($(TARGET_BUILD_VARIANT),userdebug)
        TARGET_KERNEL_CONFIG := axolotl_userdebug_defconfig
    else
        TARGET_KERNEL_CONFIG := axolotl_user_defconfig
    endif
endif
