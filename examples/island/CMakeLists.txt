project(SFMLIslandExample CXX)

sfml_add_example(island GUI_APP SOURCES Island.cpp DEPENDS SFML::Graphics)

find_package(Threads REQUIRED)
target_link_libraries(island PRIVATE Threads::Threads)

sfml_find_path_required(STB_PERLIN_INCLUDE_DIR stb_perlin.h)
target_include_directories(island SYSTEM PRIVATE "${STB_PERLIN_INCLUDE_DIR}")
