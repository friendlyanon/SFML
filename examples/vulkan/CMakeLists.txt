project(SFMLVulkanExample CXX)

sfml_add_example(vulkan GUI_APP SOURCES Vulkan.cpp DEPENDS SFML::Graphics)

target_include_directories(vulkan SYSTEM PRIVATE "${PROJECT_SOURCE_DIR}")
