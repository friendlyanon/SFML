project(SFMLSoundCaptureExample CXX)

sfml_add_example(sound-capture SOURCES SoundCapture.cpp DEPENDS SFML::Audio)
