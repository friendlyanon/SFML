project(SFMLOpenGLExample CXX)

set(RESOURCES "")
if(SFML_OS_IOS)
    set(
        RESOURCES
        "${PROJECT_SOURCE_DIR}/resources/background.jpg"
        "${PROJECT_SOURCE_DIR}/resources/tuffy.ttf"
    )
    set_source_files_properties(${RESOURCES} PROPERTIES MACOSX_PACKAGE_LOCATION Resources)
endif()

sfml_add_example(opengl GUI_APP SOURCES OpenGL.cpp BUNDLE_RESOURCES ${RESOURCES} DEPENDS SFML::Graphics)

target_include_directories(opengl SYSTEM PRIVATE "${PROJECT_SOURCE_DIR}")
