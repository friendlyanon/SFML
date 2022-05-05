cmake_minimum_required(VERSION 3.16)

include(cmake/Prelude.cmake)

project(
    SFML
    VERSION 3.0.0
    DESCRIPTION "Simple and Fast Multimedia Library"
    HOMEPAGE_URL "https://www.sfml-dev.org/"
    LANGUAGES CXX # also C and OBJCXX in some modules and OBJC in the Cocoa example
)

set(SFML_VERSION_IS_RELEASE NO)
set(SFML_ABI_SOVERSION 3)

include(CMakeDependentOption)
include(GNUInstallDirs)
include(cmake/Config.cmake)
include(cmake/Macros.cmake)

set(SFML_MODULES System Main Network Audio Window Graphics) # Graphics depends on Window
foreach(module IN LISTS SFML_MODULES)
    sfml_add_module("${module}")
endforeach()

cmake_dependent_option(SFML_BUILD_EXAMPLES "Enable to build the SFML examples" "${SFML_DEVELOPER_MODE}" "NOT;SFML_HAS_SKIPPED_MODULE" OFF)
if(SFML_BUILD_EXAMPLES)
    add_subdirectory(examples)
endif()

if(NOT CMAKE_SKIP_INSTALL_RULES)
    include(cmake/InstallRules.cmake)
endif()

if(NOT SFML_DEVELOPER_MODE)
    return()
endif()

include(CTest)
if(BUILD_TESTING)
    if(SFML_HAS_SKIPPED_MODULE)
        message(WARNING "Cannot build unit testing unless all modules are enabled")
    else()
        add_subdirectory(test)
    endif()
endif()
