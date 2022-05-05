project(SFMLCocoaExample OBJC OBJCXX)

# Usage: compile_xib(INPUT /absolute/path/to/file.xib OUTPUT /absolute/path/to/file.nib)
function(compile_xib)
    cmake_parse_arguments(PARSE_ARGV 0 THIS "" "INPUT;OUTPUT" "")
    foreach(var IN LISTS THIS_KEYWORDS_MISSING_VALUES)
        string(SUBSTRING "${var}" 5 -1 var)
        message(FATAL_ERROR "Missing required argument ${var} in call to compile_xib()")
    endforeach()

    find_program(IBTOOL ibtool)
    if(NOT IBTOOL)
        message(FATAL_ERROR "ibtool is required to compile .xib files but wasn't found")
    endif()

    # Default args taken from Xcode 9 when it generates a nib from a xib
    set(DEFAULT_ARGS --errors --warnings --notices --module cocoa --auto-activate-custom-fonts --target-device mac --output-format human-readable-text)

    add_custom_command(
        OUTPUT "${THIS_OUTPUT}"
        COMMAND "${IBTOOL}" ${DEFAULT_ARGS} "${THIS_INPUT}" --compile "${THIS_OUTPUT}"
        MAIN_DEPENDENCY "${THIS_INPUT}"
        COMMENT "Generating ${THIS_OUTPUT}"
        VERBATIM
    )
endfunction()

compile_xib(INPUT "${PROJECT_SOURCE_DIR}/MainMenu.xib" OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/MainMenu.nib")

set(
    RESOURCES
    "${PROJECT_SOURCE_DIR}/resources/icon.icns"
    "${PROJECT_SOURCE_DIR}/resources/tuffy.ttf"
    "${PROJECT_SOURCE_DIR}/resources/logo.png"
    "${PROJECT_SOURCE_DIR}/resources/blue.png"
    "${PROJECT_SOURCE_DIR}/resources/green.png"
    "${PROJECT_SOURCE_DIR}/resources/red.png"
    "${PROJECT_SOURCE_DIR}/resources/Credits.rtf"
    "${CMAKE_CURRENT_BINARY_DIR}/MainMenu.nib"
)
set_source_files_properties(${RESOURCES} PROPERTIES MACOSX_PACKAGE_LOCATION Resources)

sfml_add_example(
    cocoa GUI_APP
    BUNDLE_RESOURCES ${RESOURCES}
    DEPENDS SFML::System SFML::Window SFML::Graphics "-framework Cocoa" "-framework Foundation"
    SOURCES
    "${PROJECT_SOURCE_DIR}/CocoaAppDelegate.h"
    "${PROJECT_SOURCE_DIR}/CocoaAppDelegate.mm"
    "${PROJECT_SOURCE_DIR}/NSString+stdstring.h"
    "${PROJECT_SOURCE_DIR}/NSString+stdstring.mm"
    "${PROJECT_SOURCE_DIR}/main.m"
)
set_property(
    TARGET cocoa PROPERTY
    MACOSX_BUNDLE_INFO_PLIST "${PROJECT_SOURCE_DIR}/resources/Cocoa-Info.plist"
)
