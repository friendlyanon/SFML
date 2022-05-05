# Allow package maintainers to freely override the path for the configs
set(SFML_INSTALL_CMAKEDIR "${CMAKE_INSTALL_LIBDIR}/cmake/SFML" CACHE PATH "CMake package config location relative to the install prefix")
mark_as_advanced(SFML_INSTALL_CMAKEDIR)

# Make these options visible for CMake's GUI and TUI
option(SFML_DEVELOPER_MODE "Enable developer mode" OFF)
mark_as_advanced(SFML_DEVELOPER_MODE)
option(BUILD_SHARED_LIBS "Enable to build shared libraries" OFF)

# Enable selecting modules to build (see GH-798)
set(SFML_BUILD_MAIN ON)
set(SFML_BUILD_SYSTEM ON)
option(SFML_BUILD_WINDOW "Enable to build SFML's Window module" ON)
cmake_dependent_option(SFML_BUILD_GRAPHICS "Enable to build SFML's Graphics module" ON SFML_BUILD_WINDOW OFF)
option(SFML_BUILD_AUDIO "Enable to build SFML's Audio module" ON)
option(SFML_BUILD_NETWORK "Enable to build SFML's Network module" ON)
mark_as_advanced(SFML_BUILD_WINDOW SFML_BUILD_GRAPHICS SFML_BUILD_AUDIO SFML_BUILD_NETWORK)
set(SFML_HAS_SKIPPED_MODULE NO)

# Prefer building with -pthread when applicable
option(THREADS_PREFER_PTHREAD_FLAG "Prefer the -pthread flag for compilers and platforms when applicable" ON)
mark_as_advanced(THREADS_PREFER_PTHREAD_FLAG)

# Detect the OS
set(OPENGL_ES 0)
if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
    set(SFML_OS_WINDOWS 1)
elseif(CMAKE_SYSTEM_NAME STREQUAL "Linux")
    set(SFML_OS_LINUX 1)
elseif(CMAKE_SYSTEM_NAME MATCHES "^k?FreeBSD\$")
    set(SFML_OS_FREEBSD 1)
elseif(CMAKE_SYSTEM_NAME STREQUAL "OpenBSD")
    set(SFML_OS_OPENBSD 1)
elseif(CMAKE_SYSTEM_NAME STREQUAL "NetBSD")
    set(SFML_OS_NETBSD 1)
elseif(CMAKE_SYSTEM_NAME STREQUAL "iOS")
    set(SFML_OS_IOS 1)
    set(OPENGL_ES 1)
elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
    set(SFML_OS_MACOSX 1)

    if(CMAKE_SYSTEM_VERSION VERSION_LESS "10.7")
        message(FATAL_ERROR "Unsupported version of OS X: ${CMAKE_SYSTEM_VERSION}")
    endif()
elseif(CMAKE_SYSTEM_NAME STREQUAL "Android")
    set(SFML_OS_ANDROID 1)
    set(OPENGL_ES 1)
# comparing CMAKE_SYSTEM_NAME with "CYGWIN" generates a false warning depending on the CMake version
# let's avoid it so the actual error is more visible
elseif(CYGWIN)
    message(FATAL_ERROR "Unfortunately SFML doesn't support Cygwin's 'hybrid' status between both Windows and Linux derivatives.\nIf you insist on using the GCC, please use a standalone build of MinGW without the Cygwin environment instead")
else()
    message(FATAL_ERROR "Unsupported operating system or environment")
endif()

# detect the compiler
# Note: The detection is order is important because, Visual Studio can use both
# MSVC (cl) and Clang (clang-cl)
if(MSVC)
    set(SFML_COMPILER_MSVC 1)
elseif(CMAKE_CXX_COMPILER_ID MATCHES Clang)
    set(SFML_COMPILER_CLANG 1)
elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    set(SFML_COMPILER_GCC 1)
else()
    message(FATAL_ERROR "This compiler is not yet known by SFML (${CMAKE_CXX_COMPILER_ID})")
endif()

# Linux and BSD options
if(SFML_OS_LINUX OR SFML_OS_FREEBSD OR SFML_OS_OPENBSD OR SFML_OS_NETBSD)
    option(SFML_USE_DRM "Use libdrm and libgbm instead of X11 for the Window module" OFF)
    mark_as_advanced(SFML_USE_DRM)
endif()

# Android options
if(SFML_OS_ANDROID)
    if(CMAKE_ANDROID_API LESS "26")
        message(FATAL_ERROR "Android API level (${CMAKE_ANDROID_API}) must be equal to or greater than 26")
    endif()

    option(SFML_ANDROID_USE_SUSPEND_AWARE_CLOCK "Enable to use an sf::Clock implementation which takes system sleep time into account (keeps advancing during suspension), otherwise to default to another available monotonic clock" OFF)
endif()

# iOS options
if(SFML_OS_IOS)
    set(SFML_IOS_DEPLOYMENT_TARGET 13.0 CACHE STRING "The minimal iOS version that will be able to run the built binaries. Cannot be lower than 10.2")
    if(SFML_IOS_DEPLOYMENT_TARGET VERSION_LESS "10.2")
        message(FATAL_ERROR "SFML_IOS_DEPLOYMENT_TARGET cannot be lower than 10.2, got ${SFML_IOS_DEPLOYMENT_TARGET}")
    endif()

    set(SFML_CODE_SIGN_IDENTITY "iPhone Developer" CACHE STRING "The code signing identity to use when building for a real device")
endif()

# define SFML_OPENGL_ES if needed
cmake_dependent_option(SFML_OPENGL_ES "Enable to use an OpenGL ES implementation, otherwise use a desktop OpenGL implementation" "${OPENGL_ES}" SFML_BUILD_WINDOW OFF)

# OSX options
cmake_dependent_option(SFML_BUILD_FRAMEWORKS "Enable to build SFML as framework libraries" OFF SFML_OS_MACOSX OFF)

# Output variables to the config header
configure_file("${SFML_SOURCE_DIR}/include/SFML/Config.hpp.in" configured/SFML/Config.hpp @ONLY)
include_directories("${SFML_BINARY_DIR}/configured")
