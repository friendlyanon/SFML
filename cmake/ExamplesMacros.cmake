function(sfml_add_example target)
    cmake_parse_arguments(PARSE_ARGV 1 THIS GUI_APP RESOURCES_DIR "SOURCES;BUNDLE_RESOURCES;DEPENDS")

    source_group("" FILES ${THIS_SOURCES})
    if(DEFINED THIS_BUNDLE_RESOURCES)
        list(APPEND THIS_SOURCES ${THIS_BUNDLE_RESOURCES})
    endif()

    if(THIS_GUI_APP AND SFML_OS_WINDOWS)
        add_executable("${target}" WIN32)
        target_link_libraries("${target}" PRIVATE SFML::Main)
    elseif(THIS_GUI_APP AND SFML_OS_IOS)
        set(info_plist "${SFML_SOURCE_DIR}/examples/assets/info.plist")
        set(
            resources
            "${SFML_SOURCE_DIR}/examples/assets/LaunchScreen.storyboard"
            "${SFML_SOURCE_DIR}/examples/assets/logo.png"
            "${SFML_SOURCE_DIR}/examples/assets/icon.icns"
            "${info_plist}"
        )
        add_executable("${target}" MACOSX_BUNDLE ${resources})
        set_target_properties(
            "${target}" PROPERTIES
            RESOURCE "${resources}"
            MACOSX_BUNDLE_INFO_PLIST "${info_plist}"
        )
        target_link_libraries("${target}" PRIVATE SFML::Main)
    else()
        add_executable("${target}")
    endif()

    target_sources("${target}" PRIVATE ${THIS_SOURCES})

    set_target_properties(
        "${target}" PROPERTIES
        FOLDER Examples
        VS_DEBUGGER_WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
    )

    if(DEFINED THIS_DEPENDS)
        target_link_libraries("${target}" PRIVATE ${THIS_DEPENDS})
    endif()

    if(SFML_OS_IOS)
        sfml_set_common_ios_properties("${target}")
    endif()

    set(example_tgt "example-${target}")
    set_property(DIRECTORY "${SFMLExamples_SOURCE_DIR}" APPEND PROPERTY SFML_EXAMPLES "${example_tgt}")
    add_custom_target(
        "${example_tgt}"
        COMMAND "${target}"
        WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
        VERBATIM
    )
    add_dependencies("${example_tgt}" "${target}")
endfunction()
