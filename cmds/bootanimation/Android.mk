LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
    bootanimation_main.cpp \
    audioplay.cpp \
    BootAnimation.cpp

LOCAL_CFLAGS += -DGL_GLEXT_PROTOTYPES -DEGL_EGLEXT_PROTOTYPES

LOCAL_CFLAGS += -Wall -Werror -Wunused -Wunreachable-code

LOCAL_C_INCLUDES += \
    external/tinyalsa/include \
    frameworks/wilhelm/include

LOCAL_SHARED_LIBRARIES := \
    libcutils \
    liblog \
    libandroidfw \
    libutils \
    libbinder \
    libui \
    libskia \
    libEGL \
    libGLESv1_CM \
    libgui \
	libOpenSLES \
    libtinyalsa \
    libregionalization

ifneq ($(TARGET_BOOTANIMATION_MULTITHREAD_DECODE),false)
    LOCAL_CFLAGS += -DMULTITHREAD_DECODE
endif

ifeq ($(TARGET_BOOTANIMATION_PRELOAD),true)
    LOCAL_CFLAGS += -DPRELOAD_BOOTANIMATION
endif

ifeq ($(TARGET_BOOTANIMATION_TEXTURE_CACHE),true)
    LOCAL_CFLAGS += -DNO_TEXTURE_CACHE=0
endif

ifeq ($(TARGET_BOOTANIMATION_TEXTURE_CACHE),false)
    LOCAL_CFLAGS += -DNO_TEXTURE_CACHE=1
endif

ifeq ($(TARGET_BOOTANIMATION_USE_RGB565),true)
    LOCAL_CFLAGS += -DUSE_565
endif

LOCAL_MODULE:= bootanimation

LOCAL_INIT_RC := bootanim.rc

ifdef TARGET_32_BIT_SURFACEFLINGER
LOCAL_32_BIT_ONLY := true
endif

include $(BUILD_EXECUTABLE)
