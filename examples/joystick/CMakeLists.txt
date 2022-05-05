project(SFMLJoystickExample CXX)

sfml_add_example(joystick GUI_APP SOURCES Joystick.cpp DEPENDS SFML::Graphics)
