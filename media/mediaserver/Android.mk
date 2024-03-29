LOCAL_PATH:= $(call my-dir)

ifneq ($(BOARD_USE_CUSTOM_MEDIASERVEREXTENSIONS),true)
include $(CLEAR_VARS)
LOCAL_SRC_FILES := register.cpp
LOCAL_MODULE := libregistermsext
LOCAL_MODULE_TAGS := optional
LOCAL_CFLAGS := -Werror -Wall
include $(BUILD_STATIC_LIBRARY)
endif

include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
        main_mediaserver.cpp

LOCAL_SHARED_LIBRARIES := \
        libresourcemanagerservice \
        liblog \
        libmediaplayerservice \
        libutils \
        libbinder \
        libicuuc \
        android.hardware.media.omx@1.0 \

LOCAL_STATIC_LIBRARIES := \
        libicuandroid_utils \
        libregistermsext

LOCAL_C_INCLUDES := \
        frameworks/av/media/libmediaplayerservice \
        frameworks/av/services/mediaresourcemanager \

LOCAL_MODULE:= mediaserver
LOCAL_32_BIT_ONLY := true

LOCAL_INIT_RC := mediaserver.rc

LOCAL_CFLAGS := -Werror -Wall

ifeq ($(TARGET_HAS_LEGACY_CAMERA_HAL1),true)
    LOCAL_CFLAGS += -DNO_CAMERA_SERVER

    LOCAL_SHARED_LIBRARIES += \
        libcameraservice \
        libgui \
        libhidltransport \
        android.hardware.camera.common@1.0 \
        android.hardware.camera.provider@2.4
    
    LOCAL_WHOLE_STATIC_LIBRARIES += \
		libarect
        
endif

include $(BUILD_EXECUTABLE)
