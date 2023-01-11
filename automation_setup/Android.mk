#
# Copyright (C) 2022-2023 SHIFT GmbH
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := automation_trigger
LOCAL_MODULE_STEM := trigger
LOCAL_SRC_FILES := trigger
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_DATA)/userdata_automation
LOCAL_REQUIRED_MODULES := automation_adb_keys
include $(BUILD_PREBUILT)
