sfml_add_library(Graphics)

sfml_define_src_inc_variables()

sfml_target_sources(
    sfml-graphics GROUP "" FILES
    ${src}/BlendMode.cpp
    ${inc}/BlendMode.hpp
    ${inc}/Color.hpp
    ${inc}/Color.inl
    ${inc}/Export.hpp
    ${src}/Font.cpp
    ${inc}/Font.hpp
    ${src}/Glsl.cpp
    ${inc}/Glsl.hpp
    ${inc}/Glsl.inl
    ${inc}/Glyph.hpp
    ${src}/GLCheck.cpp
    ${src}/GLCheck.hpp
    ${src}/GLExtensions.hpp
    ${src}/GLExtensions.cpp
    ${src}/Image.cpp
    ${inc}/Image.hpp
    ${src}/ImageLoader.cpp
    ${src}/ImageLoader.hpp
    ${inc}/PrimitiveType.hpp
    ${inc}/Rect.hpp
    ${inc}/Rect.inl
    ${src}/RenderStates.cpp
    ${inc}/RenderStates.hpp
    ${src}/RenderTexture.cpp
    ${inc}/RenderTexture.hpp
    ${src}/RenderTarget.cpp
    ${inc}/RenderTarget.hpp
    ${src}/RenderWindow.cpp
    ${inc}/RenderWindow.hpp
    ${src}/Shader.cpp
    ${inc}/Shader.hpp
    ${src}/Texture.cpp
    ${inc}/Texture.hpp
    ${src}/TextureSaver.cpp
    ${src}/TextureSaver.hpp
    ${src}/Transform.cpp
    ${inc}/Transform.hpp
    ${inc}/Transform.inl
    ${src}/Transformable.cpp
    ${inc}/Transformable.hpp
    ${src}/View.cpp
    ${inc}/View.hpp
    ${inc}/Vertex.hpp
    ${inc}/Vertex.inl
)

sfml_target_sources(
    sfml-graphics GROUP drawables FILES
    ${inc}/Drawable.hpp
    ${src}/Shape.cpp
    ${inc}/Shape.hpp
    ${src}/CircleShape.cpp
    ${inc}/CircleShape.hpp
    ${src}/RectangleShape.cpp
    ${inc}/RectangleShape.hpp
    ${src}/ConvexShape.cpp
    ${inc}/ConvexShape.hpp
    ${src}/Sprite.cpp
    ${inc}/Sprite.hpp
    ${src}/Text.cpp
    ${inc}/Text.hpp
    ${src}/VertexArray.cpp
    ${inc}/VertexArray.hpp
    ${src}/VertexBuffer.cpp
    ${inc}/VertexBuffer.hpp
)

sfml_target_sources(
    sfml-graphics GROUP "render texture" FILES
    ${src}/RenderTextureImpl.cpp
    ${src}/RenderTextureImpl.hpp
    ${src}/RenderTextureImplFBO.cpp
    ${src}/RenderTextureImplFBO.hpp
    ${src}/RenderTextureImplDefault.cpp
    ${src}/RenderTextureImplDefault.hpp
)

target_link_libraries(sfml-graphics PUBLIC SFML::Window)

target_include_directories(sfml-graphics SYSTEM PRIVATE "${SFML_SOURCE_DIR}/src/glad")

sfml_find_path_required(STB_IMAGE_H_INCLUDE_DIR stb_image.h)
sfml_find_path_required(STB_IMAGE_WRITE_H_INCLUDE_DIR stb_image_write.h)
target_include_directories(sfml-graphics SYSTEM PRIVATE "${STB_IMAGE_H_INCLUDE_DIR}" "${STB_IMAGE_WRITE_H_INCLUDE_DIR}")
# Use more user-friendly error messages
target_compile_definitions(sfml-graphics PRIVATE STBI_FAILURE_USERMSG)

if(SFML_OS_ANDROID OR SFML_OS_IOS)
    find_package(ZLIB REQUIRED)
    target_link_libraries(sfml-graphics PRIVATE ZLIB::ZLIB)
endif()

if(SFML_OS_IOS)
    find_package(BZip2 REQUIRED)
    target_link_libraries(sfml-graphics PRIVATE BZip2::BZip2)
endif()

find_package(Freetype REQUIRED)
target_link_libraries(sfml-graphics PRIVATE Freetype::Freetype)

# starting from Visual Studio 2015, inline versions of some C functions are used; for compatibility link this library
# see https://docs.microsoft.com/en-us/cpp/porting/overview-of-potential-upgrade-issues-visual-cpp?view=msvc-160#libraries
if(SFML_COMPILER_MSVC OR (SFML_COMPILER_CLANG AND SFML_OS_WINDOWS AND NOT MINGW))
    target_link_libraries(sfml-graphics PRIVATE legacy_stdio_definitions.lib)
endif()

# ImageLoader.cpp must be compiled with the -fno-strict-aliasing
# when gcc is used; otherwise saving PNGs may crash in stb_image_write
if(SFML_COMPILER_GCC)
    set_source_files_properties(${src}/ImageLoader.cpp PROPERTIES COMPILE_FLAGS -fno-strict-aliasing)
endif()
