sfml_add_library(Window)

sfml_define_src_inc_variables()

sfml_target_sources(
    sfml-window GROUP "" FILES
    ${inc}/Clipboard.hpp
    ${src}/Clipboard.cpp
    ${src}/ClipboardImpl.hpp
    ${src}/Context.cpp
    ${inc}/Context.hpp
    ${src}/Cursor.cpp
    ${inc}/Cursor.hpp
    ${src}/CursorImpl.hpp
    ${src}/EGLCheck.cpp
    ${src}/EGLCheck.hpp
    ${src}/EglContext.cpp
    ${src}/EglContext.hpp
    ${inc}/Export.hpp
    ${src}/GlContext.cpp
    ${src}/GlContext.hpp
    ${src}/GlResource.cpp
    ${inc}/GlResource.hpp
    ${inc}/ContextSettings.hpp
    ${inc}/Event.hpp
    ${src}/InputImpl.hpp
    ${inc}/Joystick.hpp
    ${src}/Joystick.cpp
    ${src}/JoystickImpl.hpp
    ${src}/JoystickManager.cpp
    ${src}/JoystickManager.hpp
    ${inc}/Keyboard.hpp
    ${src}/Keyboard.cpp
    ${inc}/Mouse.hpp
    ${src}/Mouse.cpp
    ${inc}/Touch.hpp
    ${src}/Touch.cpp
    ${inc}/Sensor.hpp
    ${src}/Sensor.cpp
    ${src}/SensorImpl.hpp
    ${src}/SensorManager.cpp
    ${src}/SensorManager.hpp
    ${src}/VideoMode.cpp
    ${inc}/VideoMode.hpp
    ${src}/VideoModeImpl.hpp
    ${src}/Vulkan.cpp
    ${inc}/Vulkan.hpp
    ${src}/Window.cpp
    ${inc}/Window.hpp
    ${src}/WindowBase.cpp
    ${inc}/WindowBase.hpp
    ${inc}/WindowHandle.hpp
    ${src}/WindowImpl.cpp
    ${src}/WindowImpl.hpp
    ${inc}/WindowStyle.hpp
)

if(SFML_OS_WINDOWS)
    sfml_target_sources(
        sfml-window GROUP windows FILES
        ${src}/Win32/CursorImpl.hpp
        ${src}/Win32/CursorImpl.cpp
        ${src}/Win32/ClipboardImpl.hpp
        ${src}/Win32/ClipboardImpl.cpp
        ${src}/Win32/WglContext.cpp
        ${src}/Win32/WglContext.hpp
        ${src}/Win32/InputImpl.cpp
        ${src}/Win32/InputImpl.hpp
        ${src}/Win32/JoystickImpl.cpp
        ${src}/Win32/JoystickImpl.hpp
        ${src}/Win32/SensorImpl.hpp
        ${src}/Win32/SensorImpl.cpp
        ${src}/Win32/VideoModeImpl.cpp
        ${src}/Win32/VulkanImplWin32.cpp
        ${src}/Win32/VulkanImplWin32.hpp
        ${src}/Win32/WindowImplWin32.cpp
        ${src}/Win32/WindowImplWin32.hpp
    )
    target_compile_definitions(
        sfml-window PRIVATE
        UNICODE # affects Windows headers
        _UNICODE # affects CRT headers
    )
elseif(SFML_OS_LINUX OR SFML_OS_FREEBSD OR SFML_OS_OPENBSD OR SFML_OS_NETBSD)
    if(SFML_USE_DRM)
        target_compile_definitions(sfml-window PRIVATE SFML_USE_DRM)
        sfml_target_sources(
            sfml-window GROUP unix FILES
            ${src}/DRM/CursorImpl.hpp
            ${src}/DRM/CursorImpl.cpp
            ${src}/DRM/ClipboardImpl.hpp
            ${src}/DRM/ClipboardImpl.cpp
            ${src}/Unix/SensorImpl.cpp
            ${src}/Unix/SensorImpl.hpp
            ${src}/DRM/InputImplUDev.cpp
            ${src}/DRM/InputImplUDev.hpp
            ${src}/DRM/VideoModeImpl.cpp
            ${src}/DRM/DRMContext.cpp
            ${src}/DRM/DRMContext.hpp
            ${src}/DRM/WindowImplDRM.cpp
            ${src}/DRM/WindowImplDRM.hpp
        )
    else()
        sfml_target_sources(
            sfml-window GROUP unix FILES
            ${src}/Unix/CursorImpl.hpp
            ${src}/Unix/CursorImpl.cpp
            ${src}/Unix/ClipboardImpl.hpp
            ${src}/Unix/ClipboardImpl.cpp
            ${src}/Unix/InputImpl.cpp
            ${src}/Unix/InputImpl.hpp
            ${src}/Unix/SensorImpl.cpp
            ${src}/Unix/SensorImpl.hpp
            ${src}/Unix/Display.cpp
            ${src}/Unix/Display.hpp
            ${src}/Unix/GlxContext.cpp
            ${src}/Unix/GlxContext.hpp
            ${src}/Unix/VideoModeImpl.cpp
            ${src}/Unix/VulkanImplX11.cpp
            ${src}/Unix/VulkanImplX11.hpp
            ${src}/Unix/WindowImplX11.cpp
            ${src}/Unix/WindowImplX11.hpp
        )
    endif()
    if(SFML_OS_LINUX)
        sfml_target_sources(
            sfml-window GROUP unix FILES
            ${src}/Unix/JoystickImpl.cpp
            ${src}/Unix/JoystickImpl.hpp
        )
    elseif(SFML_OS_FREEBSD)
        sfml_target_sources(
            sfml-window GROUP unix FILES
            ${src}/FreeBSD/JoystickImpl.cpp
            ${src}/FreeBSD/JoystickImpl.hpp
        )
    elseif(SFML_OS_OPENBSD)
        sfml_target_sources(
            sfml-window GROUP unix FILES
            ${src}/OpenBSD/JoystickImpl.cpp
            ${src}/OpenBSD/JoystickImpl.hpp
        )
    elseif(SFML_OS_NETBSD)
        sfml_target_sources(
            sfml-window GROUP unix FILES
            ${src}/NetBSD/JoystickImpl.cpp
            ${src}/NetBSD/JoystickImpl.hpp
        )
    endif()
elseif(SFML_OS_MACOSX)
    enable_language(OBJCXX)
    sfml_target_sources(
        sfml-window GROUP mac FILES
        ${src}/OSX/cpp_objc_conversion.h
        ${src}/OSX/cpp_objc_conversion.mm
        ${src}/OSX/cg_sf_conversion.hpp
        ${src}/OSX/cg_sf_conversion.mm
        ${src}/OSX/CursorImpl.hpp
        ${src}/OSX/CursorImpl.mm
        ${src}/OSX/ClipboardImpl.hpp
        ${src}/OSX/ClipboardImpl.mm
        ${src}/OSX/InputImpl.mm
        ${src}/OSX/InputImpl.hpp
        ${src}/OSX/HIDInputManager.hpp
        ${src}/OSX/HIDInputManager.mm
        ${src}/OSX/HIDJoystickManager.hpp
        ${src}/OSX/HIDJoystickManager.cpp
        ${src}/OSX/JoystickImpl.cpp
        ${src}/OSX/JoystickImpl.hpp
        ${src}/OSX/NSImage+raw.h
        ${src}/OSX/NSImage+raw.mm
        ${src}/OSX/Scaling.h
        ${src}/OSX/SensorImpl.cpp
        ${src}/OSX/SensorImpl.hpp
        ${src}/OSX/SFApplication.h
        ${src}/OSX/SFApplication.m
        ${src}/OSX/SFApplicationDelegate.h
        ${src}/OSX/SFApplicationDelegate.m
        ${src}/OSX/SFContext.hpp
        ${src}/OSX/SFContext.mm
        ${src}/OSX/SFKeyboardModifiersHelper.h
        ${src}/OSX/SFKeyboardModifiersHelper.mm
        ${src}/OSX/SFOpenGLView.h
        ${src}/OSX/SFOpenGLView.mm
        ${src}/OSX/SFOpenGLView+keyboard.mm
        ${src}/OSX/SFOpenGLView+keyboard_priv.h
        ${src}/OSX/SFOpenGLView+mouse.mm
        ${src}/OSX/SFOpenGLView+mouse_priv.h
        ${src}/OSX/SFSilentResponder.h
        ${src}/OSX/SFSilentResponder.m
        ${src}/OSX/SFWindow.h
        ${src}/OSX/SFWindow.m
        ${src}/OSX/SFWindowController.h
        ${src}/OSX/SFWindowController.mm
        ${src}/OSX/SFViewController.h
        ${src}/OSX/SFViewController.mm
        ${src}/OSX/VideoModeImpl.cpp
        ${src}/OSX/WindowImplCocoa.hpp
        ${src}/OSX/WindowImplCocoa.mm
        ${src}/OSX/WindowImplDelegateProtocol.h
        ${src}/OSX/AutoreleasePoolWrapper.hpp
        ${src}/OSX/AutoreleasePoolWrapper.mm
    )
elseif(SFML_OS_IOS)
    enable_language(OBJCXX)
    sfml_target_sources(
        sfml-window GROUP ios FILES
        ${src}/iOS/CursorImpl.hpp
        ${src}/iOS/CursorImpl.cpp
        ${src}/iOS/ClipboardImpl.mm
        ${src}/iOS/ClipboardImpl.hpp
        ${src}/iOS/EaglContext.mm
        ${src}/iOS/EaglContext.hpp
        ${src}/iOS/InputImpl.mm
        ${src}/iOS/InputImpl.hpp
        ${src}/iOS/JoystickImpl.mm
        ${src}/iOS/JoystickImpl.hpp
        ${src}/iOS/SensorImpl.mm
        ${src}/iOS/SensorImpl.hpp
        ${src}/iOS/VideoModeImpl.mm
        ${src}/iOS/WindowImplUIKit.hpp
        ${src}/iOS/WindowImplUIKit.mm
        ${src}/iOS/ObjCType.hpp
        ${src}/iOS/SFAppDelegate.hpp
        ${src}/iOS/SFAppDelegate.mm
        ${src}/iOS/SFView.hpp
        ${src}/iOS/SFView.mm
        ${src}/iOS/SFViewController.hpp
        ${src}/iOS/SFViewController.mm
        ${src}/iOS/SFMain.hpp
        ${src}/iOS/SFMain.mm
    )
elseif(SFML_OS_ANDROID)
    sfml_target_sources(
        sfml-window GROUP android FILES
        ${src}/Android/CursorImpl.hpp
        ${src}/Android/CursorImpl.cpp
        ${src}/Android/ClipboardImpl.hpp
        ${src}/Android/ClipboardImpl.cpp
        ${src}/Android/WindowImplAndroid.hpp
        ${src}/Android/WindowImplAndroid.cpp
        ${src}/Android/VideoModeImpl.cpp
        ${src}/Android/InputImpl.hpp
        ${src}/Android/InputImpl.cpp
        ${src}/Android/JoystickImpl.hpp
        ${src}/Android/JoystickImpl.cpp
        ${src}/Android/SensorImpl.hpp
        ${src}/Android/SensorImpl.cpp
    )
endif()

target_link_libraries(sfml-window PUBLIC SFML::System)

target_include_directories(sfml-window SYSTEM PRIVATE "${SFML_SOURCE_DIR}/src/glad")

find_package(Vulkan REQUIRED)
target_link_libraries(sfml-window PRIVATE Vulkan::Vulkan)

if(SFML_OS_LINUX OR SFML_OS_FREEBSD OR SFML_OS_OPENBSD OR SFML_OS_NETBSD)
    if(SFML_USE_DRM)
        # drm: 3rd party (libdrm-dev), via libdrm.pc
        # gbm: 3rd party (libgbm-dev), via gbm.pc
        find_package(PkgConfig REQUIRED)
        pkg_check_modules(drm REQUIRED IMPORTED_TARGET libdrm)
        pkg_check_modules(gbm REQUIRED IMPORTED_TARGET gbm)

        enable_language(C)
        add_library(sfml-drm-common OBJECT "${SFML_SOURCE_DIR}/src/drm/drm-common.c")
        target_include_directories(sfml-drm-common PUBLIC "${SFML_SOURCE_DIR}/src/drm")
        target_compile_features(sfml-drm-common PRIVATE c_std_99)
        target_link_libraries(sfml-drm-common PUBLIC PkgConfig::drm PkgConfig::gbm)
        target_link_libraries(sfml-window PRIVATE sfml-drm-common)
    else()
        find_package(X11 REQUIRED)
        target_link_libraries(sfml-window PRIVATE X11::Xrandr X11::Xcursor)
    endif()
endif()

if(SFML_OS_IOS)
    # OpenGLES: provided by the system
    target_link_libraries(sfml-window PRIVATE "-framework OpenGLES")
elseif(SFML_OS_ANDROID)
    # GLESv1_CM: provided by the system, depends on EGL; no ES support by CMake yet
    find_package(OpenGL REQUIRED EGL)
    target_link_libraries(sfml-window PRIVATE OpenGL::EGL GLESv1_CM)
else()
    find_package(OpenGL REQUIRED)
    target_link_libraries(sfml-window PRIVATE OpenGL::GL)
endif()

if(SFML_OS_WINDOWS AND NOT SFML_COMPILER_MSVC)
    # Check if the dinput.h header is available in a system location
    include(CheckIncludeFileCXX)
    check_include_file_cxx(dinput.h DINPUT_H_FOUND)
    if(NOT DINPUT_H_FOUND)
        sfml_find_path_required(DINPUT_H_INCLUDE_DIR dinput.h)
        target_include_directories(sfml-window SYSTEM PRIVATE "${DINPUT_H_INCLUDE_DIR}")
    endif()
endif()

if(SFML_OS_LINUX)
    # dl: provided by the system
    # udev: 3rd party (libudev-dev), via libudev.pc; >=143 requested for stable release
    find_package(PkgConfig REQUIRED)
    pkg_check_modules(udev REQUIRED IMPORTED_TARGET libudev>=143)
    target_link_libraries(sfml-window PRIVATE dl PkgConfig::udev)
elseif(SFML_OS_WINDOWS)
    # winmm and gdi32: provided by the system (Windows SDK)
    target_link_libraries(sfml-window PRIVATE winmm gdi32)
elseif(SFML_OS_FREEBSD)
    # usbhid: provided by the system
    target_link_libraries(sfml-window PRIVATE usbhid)
elseif(SFML_OS_MACOSX)
    # Foundation, AppKit, IOKit and Carbon: provided by the system
    target_link_libraries(sfml-window PRIVATE "-framework Foundation" "-framework AppKit" "-framework IOKit" "-framework Carbon")
elseif(SFML_OS_IOS)
    # Foundation, UIKit, CoreGraphics and CoreMotion: provided by the system
    target_link_libraries(sfml-window PRIVATE "-framework Foundation" "-framework UIKit" "-framework CoreGraphics" "-framework QuartzCore" "-framework CoreMotion")
elseif(SFML_OS_ANDROID)
    # android: provided by the system
    target_link_libraries(sfml-window PRIVATE android)
endif()
