project(SFMLSocketsExample CXX)

sfml_add_example(
    sockets
    DEPENDS SFML::Network
    SOURCES
    Sockets.cpp
    TCP.cpp
    UDP.cpp
)
