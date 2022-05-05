project(SFMLVoipExample CXX)

sfml_add_example(
    voip
    DEPENDS SFML::Audio SFML::Network
    SOURCES
    VoIP.cpp
    Client.cpp
    Server.cpp
)
