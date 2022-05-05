project(SFMLSoundExample CXX)

sfml_add_example(sound SOURCES Sound.cpp DEPENDS SFML::Audio)
