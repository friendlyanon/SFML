project(SFMLX11Example CXX)

find_package(X11 REQUIRED)
sfml_add_example(X11Example GUI_APP SOURCES X11.cpp DEPENDS SFML::Window X11::X11)

target_include_directories(X11Example SYSTEM PRIVATE "${PROJECT_SOURCE_DIR}")
