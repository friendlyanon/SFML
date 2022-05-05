project(SFMLWindowExample CXX)

sfml_add_example(window GUI_APP SOURCES Window.cpp DEPENDS SFML::Window)

target_include_directories(window SYSTEM PRIVATE "${PROJECT_SOURCE_DIR}")
