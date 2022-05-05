macro(sfml_set_xcode_property target property value)
    set_property(TARGET "${target}" PROPERTY "XCODE_ATTRIBUTE_${property}" "${value}")
endmacro()

function(sfml_set_common_ios_properties target)
    # enable automatic reference counting on iOS
    sfml_set_xcode_property("${target}" CLANG_ENABLE_OBJC_ARC YES)
    sfml_set_xcode_property("${target}" IPHONEOS_DEPLOYMENT_TARGET "${SFML_IOS_DEPLOYMENT_TARGET}")
    sfml_set_xcode_property("${target}" CODE_SIGN_IDENTITY "${SFML_CODE_SIGN_IDENTITY}")

    get_target_property(target_type "${target}" TYPE)
    if(NOT target_type STREQUAL "EXECUTABLE")
        return()
    endif()

    set_target_properties(
        "${target}" PROPERTIES
        MACOSX_BUNDLE TRUE # Bare executables are not usable on iOS, only bundle applications
        MACOSX_BUNDLE_GUI_IDENTIFIER "org.sfml-dev.${target}" # If missing, trying to launch an example in simulator will make Xcode < 9.3 crash
        MACOSX_BUNDLE_BUNDLE_NAME "${target}"
        MACOSX_BUNDLE_LONG_VERSION_STRING "${PROJECT_VERSION}"
    )
endfunction()

function(sfml_target_sources target)
    cmake_parse_arguments(PARSE_ARGV 1 THIS "" GROUP FILES)
    if(DEFINED THIS_UNPARSED_ARGUMENTS)
        message(FATAL_ERROR "Extra arguments for sfml_target_sources: ${THIS_UNPARSED_ARGUMENTS}")
    endif()

    target_sources("${target}" PRIVATE ${THIS_FILES})
    source_group("${THIS_GROUP}" FILES ${THIS_FILES})
endfunction()

function(sfml_add_library name)
    cmake_parse_arguments(PARSE_ARGV 1 THIS STATIC "" "")
    if(DEFINED THIS_UNPARSED_ARGUMENTS)
        message(FATAL_ERROR "Extra arguments for sfml_add_library: ${THIS_UNPARSED_ARGUMENTS}")
    endif()

    string(TOLOWER "sfml-${name}" target)
    set(type "")
    if(THIS_STATIC)
        set(type STATIC)
    endif()

    add_library("${target}" ${type})
    add_library("SFML::${name}" ALIAS "${target}")

    target_include_directories("${target}" PUBLIC "\$<BUILD_INTERFACE:${SFML_SOURCE_DIR}/include>")
    target_include_directories("${target}" PRIVATE "${SFML_SOURCE_DIR}/src")
    target_compile_features("${target}" PUBLIC cxx_std_17)

    string(TOUPPER "SFML_${name}_EXPORTS" export_symbol)

    set_target_properties(
        "${target}" PROPERTIES
        EXPORT_NAME "${name}"
        CXX_VISIBILITY_PRESET hidden
        OBJCXX_VISIBILITY_PRESET hidden
        VISIBILITY_INLINES_HIDDEN YES
        VERSION "${PROJECT_VERSION}"
        SOVERSION "${SFML_ABI_SOVERSION}"
        DEFINE_SYMBOL "${export_symbol}"
        FOLDER SFML
    )

    if(NOT BUILD_SHARED_LIBS)
        target_compile_definitions("${target}" PUBLIC SFML_STATIC)
    elseif(SFML_OS_WINDOWS AND NOT THIS_STATIC)
        string(TIMESTAMP RC_CURRENT_YEAR "%Y")
        set(RC_VERSION_SUFFIX "") # Add something like the git revision short SHA-1 in the future
        set(RC_PRERELEASE 0) # Set to 1 to mark the DLL as a pre-release DLL
        configure_file("${SFML_SOURCE_DIR}/tools/windows/resource.rc.in" resource.rc.in @ONLY)
        file(GENERATE OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/resource-\$<CONFIG>.rc" INPUT "${CMAKE_CURRENT_BINARY_DIR}/resource.rc.in")
        # Can't control source group for these generated files (at least in VS)
        target_sources("${target}" PRIVATE "${CMAKE_CURRENT_BINARY_DIR}/resource-\$<CONFIG>.rc")
    endif()

    if(SFML_BUILD_FRAMEWORKS)
        set_target_properties(
            "${target}" PROPERTIES
            FRAMEWORK TRUE
            FRAMEWORK_VERSION "${PROJECT_VERSION}"
            MACOSX_FRAMEWORK_IDENTIFIER "org.sfml-dev.${target}"
            MACOSX_FRAMEWORK_SHORT_VERSION_STRING "${PROJECT_VERSION}"
            MACOSX_FRAMEWORK_BUNDLE_VERSION "${PROJECT_VERSION}"
        )
    endif()

    if(SFML_OS_IOS)
        sfml_set_common_ios_properties("${target}")
    endif()

    if(CMAKE_SKIP_INSTALL_RULES)
        return()
    endif()

    set_property(DIRECTORY "${SFML_SOURCE_DIR}" PROPERTY "SFML_${SFML_CURRENT_MODULE}_HAS_EXPORT" 1)

    install(
        TARGETS "${target}"
        EXPORT "SFMLModuleTargets${SFML_CURRENT_MODULE}"
        FRAMEWORK #
        DESTINATION "${CMAKE_INSTALL_LIBDIR}"
        COMPONENT Runtime
        RUNTIME #
        COMPONENT Runtime
        LIBRARY #
        COMPONENT Runtime
        NAMELINK_COMPONENT Development
        ARCHIVE #
        COMPONENT Development
        INCLUDES #
        DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
    )
endfunction()

function(sfml_add_module module)
    string(TOUPPER "SFML_BUILD_${module}" is_enabled)
    if(${is_enabled})
        set(SFML_CURRENT_MODULE "${module}")
        add_subdirectory("src/SFML/${module}" "${module}")
    else()
        set(SFML_HAS_SKIPPED_MODULE YES)
        return()
    endif()

    get_property(has_export DIRECTORY "${SFML_SOURCE_DIR}" PROPERTY "SFML_${module}_HAS_EXPORT")
    if(CMAKE_SKIP_INSTALL_RULES OR NOT has_export)
        return()
    endif()

    set_property(DIRECTORY "${SFML_SOURCE_DIR}" APPEND PROPERTY SFML_MODULES "${module}")

    configure_file("src/SFML/${module}/Config.cmake.in" "SFMLModuleConfig${module}.cmake" @ONLY)

    install(
        FILES "${CMAKE_CURRENT_BINARY_DIR}/SFMLModuleConfig${module}.cmake"
        DESTINATION "${SFML_INSTALL_CMAKEDIR}"
        COMPONENT Development
    )

    install(
        EXPORT "SFMLModuleTargets${module}"
        NAMESPACE SFML::
        DESTINATION "${SFML_INSTALL_CMAKEDIR}"
        COMPONENT Development
    )
endfunction()

macro(sfml_define_src_inc_variables module)
    set(inc "${SFML_SOURCE_DIR}/include/SFML/${module}")
    set(src "${SFML_SOURCE_DIR}/src/SFML/${module}")
endmacro()

# Identical to the built-in find_path command, but mimics the REQUIRED argument from 3.18
macro(sfml_find_path_required variable)
    find_path(${ARGV})
    if(NOT ${variable})
        message(FATAL_ERROR "Could not find ${variable}")
    endif()
endmacro()
