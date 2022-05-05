project(SFMLFTPExample CXX)

sfml_add_example(ftp SOURCES Ftp.cpp DEPENDS SFML::Network)
