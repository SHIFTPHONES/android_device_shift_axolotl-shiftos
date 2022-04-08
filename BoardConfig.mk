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

# Radio
ADD_RADIO_FILES := true
AB_OTA_PARTITIONS += \
    ImageFv \
    abl \
    aop \
    bluetooth \
    cmnlib \
    cmnlib64 \
    devcfg  \
    dsp \
    hyp \
    keymaster \
    modem \
    qupfw \
    storsec \
    tz \
    xbl \
    xbl_config \

# Releasetools
TARGET_RELEASETOOLS_EXTENSIONS := device/shift/axolotl/shiftos
