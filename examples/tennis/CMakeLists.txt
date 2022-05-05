project(SFMLTennis CXX)

set(RESOURCES "")
if(SFML_OS_IOS)
    set(
        RESOURCES
        "${PROJECT_SOURCE_DIR}/resources/ball.wav"
        "${PROJECT_SOURCE_DIR}/resources/tuffy.ttf"
    )
    set_source_files_properties(${RESOURCES} PROPERTIES MACOSX_PACKAGE_LOCATION Resources)
endif()

sfml_add_example(
    tennis GUI_APP
    BUNDLE_RESOURCES ${RESOURCES}
    DEPENDS SFML::Audio SFML::Graphics
    SOURCES
    Tennis.cpp
)
