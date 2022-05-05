sfml_add_library(Network)

sfml_define_src_inc_variables(Network)

sfml_target_sources(
    sfml-network GROUP "" FILES
    ${inc}/Export.hpp
    ${src}/Ftp.cpp
    ${inc}/Ftp.hpp
    ${src}/Http.cpp
    ${inc}/Http.hpp
    ${src}/IpAddress.cpp
    ${inc}/IpAddress.hpp
    ${src}/Packet.cpp
    ${inc}/Packet.hpp
    ${src}/Socket.cpp
    ${inc}/Socket.hpp
    ${src}/SocketImpl.hpp
    ${inc}/SocketHandle.hpp
    ${src}/SocketSelector.cpp
    ${inc}/SocketSelector.hpp
    ${src}/TcpListener.cpp
    ${inc}/TcpListener.hpp
    ${src}/TcpSocket.cpp
    ${inc}/TcpSocket.hpp
    ${src}/UdpSocket.cpp
    ${inc}/UdpSocket.hpp
)

if(SFML_OS_WINDOWS)
    sfml_target_sources(
        sfml-network GROUP windows FILES
        ${src}/Win32/SocketImpl.cpp
        ${src}/Win32/SocketImpl.hpp
    )
else()
    sfml_target_sources(
        sfml-network GROUP unix FILES
        ${src}/Unix/SocketImpl.cpp
        ${src}/Unix/SocketImpl.hpp
    )
endif()

target_link_libraries(sfml-network PUBLIC SFML::System)

if(SFML_OS_WINDOWS)
    # ws2_32: provided by the system (Windows SDK)
    target_link_libraries(sfml-network PRIVATE ws2_32)
endif()
