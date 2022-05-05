project(SFMLTests CXX)

include("${SFML_SOURCE_DIR}/cmake/TestMacros.cmake")

find_package(doctest REQUIRED)
include(doctest)

link_libraries(doctest::doctest SFML::System)

add_library(sfml-test-main STATIC)
sfml_target_sources(
    sfml-test-main GROUP ""
    FILES
    DoctestMain.cpp
    TestUtilities/SystemUtil.hpp
    TestUtilities/SystemUtil.cpp
    TestUtilities/WindowUtil.hpp
    TestUtilities/WindowUtil.cpp
    TestUtilities/GraphicsUtil.hpp
    TestUtilities/GraphicsUtil.cpp
)

target_include_directories(sfml-test-main PUBLIC TestUtilities)

link_libraries(sfml-test-main)

sfml_add_test(
    test-sfml-system FILES
    System/Angle.cpp
    System/Clock.cpp
    System/Err.cpp
    System/FileInputStream.cpp
    System/Time.cpp
    System/Vector2.cpp
    System/Vector3.cpp
)

sfml_add_test(
    test-sfml-window DEPENDS SFML::Window FILES
    Window/ContextSettings.cpp
    Window/VideoMode.cpp
)

sfml_add_test(
    test-sfml-graphics DEPENDS SFML::Graphics FILES
    Graphics/BlendMode.cpp
    Graphics/CircleShape.cpp
    Graphics/Color.cpp
    Graphics/Rect.cpp
    Graphics/RectangleShape.cpp
    Graphics/Shape.cpp
    Graphics/Transform.cpp
    Graphics/Transformable.cpp
    Graphics/Vertex.cpp
    Graphics/VertexArray.cpp
)

sfml_add_test(
    test-sfml-network DEPENDS SFML::Network FILES
    Network/Packet.cpp
)

sfml_add_test(
    test-sfml-audio DEPENDS SFML::Audio FILES
    Audio/Dummy.cpp # TODO: Remove when there are real tests
)
