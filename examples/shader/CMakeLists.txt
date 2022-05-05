project(SFMLShaderExample CXX)

sfml_add_example(
    shader GUI_APP
    DEPENDS SFML::Graphics
    SOURCES
    Effect.hpp
    Shader.cpp
)
