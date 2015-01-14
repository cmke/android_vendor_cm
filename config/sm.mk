# Written for SaberMod toolchains
# Find host os

# Set GCC colors
export GCC_COLORS := 'error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

UNAME := $(shell uname -s)

ifeq (Linux,$(UNAME))
  HOST_OS := linux
endif

# Only use these compilers on linux host.
ifeq (linux,$(HOST_OS))

ifeq (4.8-sm,$(TARGET_GCC_VERSION))
USE_SM_TOOLCHAIN := true
endif
ifeq (4.9-sm,$(TARGET_GCC_VERSION))
USE_SM_TOOLCHAIN := true
endif

ifndef TARGET_ARCH
    $(warning ********************************************************************************)
    $(warning *  TARGET_ARCH not defined.)
    $(warning *  This is commonly set in device trees BoardConfig.mk.)
    $(warning *  Define TARGET_ARCH before including this file sm.mk)
    $(warning ********************************************************************************)
endif

# Add extra libs for the compilers to use
# Filter by TARGET_ARCH since we're pointing to ARCH specific compilers.
# To use this on new devices define TARGET_ARCH in device makefile.
ifeq (arm,$(TARGET_ARCH))
ifeq (true,$(USE_SM_TOOLCHAIN))
export LD_LIBRARY_PATH := $(ANDROID_BUILD_TOP)/prebuilts/gcc/$(HOST_PREBUILT_TAG)/arm/arm-linux-androideabi-$(TARGET_GCC_VERSION)/arch-arm/usr/lib
export LIBRARY_PATH := $(ANDROID_BUILD_TOP)/prebuilts/gcc/$(HOST_PREBUILT_TAG)/arm/arm-linux-androideabi-$(TARGET_GCC_VERSION)/arch-arm/usr/lib
endif

# Path to toolchain
SM_AND_PATH := prebuilts/gcc/$(HOST_PREBUILT_TAG)/arm/arm-linux-androideabi-$(TARGET_GCC_VERSION)
SM_AND := $(shell $(SM_AND_PATH)/bin/arm-linux-androideabi-gcc --version)

# Find strings in version info
ifneq ($(filter (SaberMod%),$(SM_AND)),)
SM_AND_VERSION := $(filter 4.8.4 4.8.5 4.8.6,$(SM_AND))
SM_AND_NAME := $(filter (SaberMod%),$(SM_AND))
SM_AND_DATE := $(filter 20140% 20141% 20150% 20151%,$(SM_AND))
SM_AND_STATUS := $(filter (release) (prerelease) (experimental),$(SM_AND))
SM_AND_VERSION := $(SM_AND_VERSION)-$(SM_AND_NAME)-$(SM_AND_DATE)-$(SM_AND_STATUS)
else
SM_AND_VERSION := $(filter 4.7 4.8 4.9 4.9.x%,$(SM_AND))
SM_AND_DATE := $(filter 20140% 20141% 20150% 20151%,$(SM_AND))
SM_AND_STATUS := $(filter (release) (prerelease) (experimental),$(SM_AND))
SM_AND_VERSION := $(SM_AND_VERSION)-$(SM_AND_DATE)-$(SM_AND_STATUS)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    ro.sm.android=$(SM_AND_VERSION)

SM_KERNEL_PATH := prebuilts/gcc/$(HOST_PREBUILT_TAG)/arm/arm-eabi-$(TARGET_GCC_VERSION_KERNEL)
SM_KERNEL := $(shell $(SM_KERNEL_PATH)/bin/arm-eabi-gcc --version)

ifneq ($(filter (SaberMod%),$(SM_KERNEL)),)
SM_KERNEL_VERSION := $(filter 4.8.4 4.8.5 4.8.6 4.9.1 4.9.2 4.9.3 4.9.4,$(SM_KERNEL))
SM_KERNEL_NAME := $(filter (SaberMod%),$(SM_KERNEL))
SM_KERNEL_DATE := $(filter 20140% 20141% 20150% 20151%,$(SM_KERNEL))
SM_KERNEL_STATUS := $(filter (release) (prerelease) (experimental),$(SM_KERNEL))
SM_KERNEL_VERSION := $(SM_KERNEL_VERSION)-$(SM_KERNEL_NAME)-$(SM_KERNEL_DATE)-$(SM_KERNEL_STATUS)
else
SM_KERNEL_VERSION := $(filter 4.7 4.8 4.9 4.9.x%,$(SM_KERNEL))
SM_KERNEL_DATE := $(filter 20140% 20141% 20150% 20151%,$(SM_KERNEL))
SM_KERNEL_STATUS := $(filter (release) (prerelease) (experimental),$(SM_KERNEL))
SM_KERNEL_VERSION := $(SM_KERNEL_VERSION)-$(SM_KERNEL_DATE)-$(SM_KERNEL_STATUS)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    ro.sm.kernel=$(SM_KERNEL_VERSION)

ifeq (true,$(GRAPHITE_OPTS))
OPT1 := (graphite)
# Graphite flags and friends
GRAPHITE_FLAGS := \
    -fgraphite \
    -fgraphite-identity \
    -floop-flatten \
    -floop-parallelize-all \
    -ftree-loop-linear \
    -floop-interchange \
    -floop-strip-mine \
    -floop-block \
    -Wno-error=maybe-uninitialized
endif
endif

ifeq (arm64,$(TARGET_ARCH))
ifeq (true,$(USE_SM_TOOLCHAIN))
export LD_LIBRARY_PATH := $(ANDROID_BUILD_TOP)/prebuilts/gcc/$(HOST_PREBUILT_TAG)/aarch64/aarch64-linux-android-$(TARGET_GCC_VERSION_EXP)/arch-arm64/usr/lib
export LIBRARY_PATH := $(ANDROID_BUILD_TOP)/prebuilts/gcc/$(HOST_PREBUILT_TAG)/aarch64/aarch64-linux-android-$(TARGET_GCC_VERSION_EXP)/arch-arm64/usr/lib
endif

# Path to toolchain
SM_AND_PATH := prebuilts/gcc/$(HOST_PREBUILT_TAG)/aarch64/aarch64-linux-android-$(TARGET_GCC_VERSION_EXP)
SM_AND := $(shell $(SM_AND_PATH)/bin/aarch64-linux-android-gcc --version)

# Find strings in version info
ifneq ($(filter (SaberMod%),$(SM_AND)),)
SM_AND_VERSION := $(filter 4.9.1 4.9.2 4.9.3 4.9.4,$(SM_AND))
SM_AND_NAME := $(filter (SaberMod%),$(SM_AND))
SM_AND_DATE := $(filter 20140% 20141% 20150% 20151%,$(SM_AND))
SM_AND_STATUS := $(filter (release) (prerelease) (experimental),$(SM_AND))
SM_AND_VERSION := $(SM_AND_VERSION)-$(SM_AND_NAME)-$(SM_AND_DATE)-$(SM_AND_STATUS)
else
SM_AND_VERSION := $(filter 4.8 4.9,$(SM_AND))
SM_AND_DATE := $(filter 20140% 20141% 20150% 20151%,$(SM_AND))
SM_AND_STATUS := $(filter (release) (prerelease) (experimental),$(SM_AND))
SM_AND_VERSION := $(SM_AND_VERSION)-$(SM_AND_DATE)-$(SM_AND_STATUS)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    ro.sm.android=$(SM_AND_VERSION)

ifeq (true,$(GRAPHITE_OPTS))
OPT1 := (graphite)
# Graphite flags and friends for ROM
GRAPHITE_FLAGS := \
    -fgraphite \
    -fgraphite-identity \
    -floop-flatten \
    -floop-parallelize-all \
    -ftree-loop-linear \
    -floop-interchange \
    -floop-strip-mine \
    -floop-block \
    -Wno-error=maybe-uninitialized
endif
endif

ifeq (true,$(GRAPHITE_OPTS))
	# Force disable some modules that are not compatible with graphite flags.
	# Add more modules if needed for devices in BoardConfig.mk
	# LOCAL_DISABLE_GRAPHITE +=
	LOCAL_DISABLE_GRAPHITE := \
	  libunwind \
	  libFFTEm \
	  libicui18n \
	  libskia \
	  libvpx \
	  libmedia_jni \
	  libstagefright_mp3dec \
	  libart \
	  mdnsd \
	  libwebrtc_spl \
	  third_party_WebKit_Source_core_webcore_svg_gyp \
	  libjni_filtershow_filters \
	  libavformat \
	  libavcodec
endif

ifeq ($(strip $(O3_OPTIMIZATIONS)),true)
    OPT2 := (max)

    # Disable some modules that break with -O3
    # Add more modules if needed for devices in BoardConfig.mk
    # LOCAL_DISABLE_O3 +=
    LOCAL_DISABLE_O3 := \
      libaudioflinger \
      libwebviewchromium

    # Don't compile -O3 with thumb to reduce code size.
    LOCAL_DISABLE_O3_FLAGS := \
      -mthumb

    # -O3 flags and friends
    O3_FLAGS := \
      -O3 \
      -Wno-error=array-bounds \
      -Wno-error=strict-overflow
endif

GCC_OPTIMIZATION_LEVELS := $(OPT1)$(OPT2)
ifneq ($(GCC_OPTIMIZATION_LEVELS),)
    PRODUCT_PROPERTY_OVERRIDES += \
      ro.sm.flags=$(GCC_OPTIMIZATION_LEVELS)
endif
else
  $(warning ********************************************************************************)
  $(warning *  SaberMod currently only works on linux host systems.)
  $(warning ********************************************************************************)
endif