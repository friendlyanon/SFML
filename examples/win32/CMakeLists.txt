project(SFMLWin32Example CXX)

sfml_add_example(win32 GUI_APP SOURCES Win32.cpp DEPENDS SFML::Graphics)
