include(CMakePackageConfigHelpers)

set(CMAKE_INSTALL_DEFAULT_COMPONENT_NAME Development)

install(
    DIRECTORY
    include/
    "${SFML_BINARY_DIR}/configured/"
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
    FILES_MATCHING
    PATTERN "*.hpp"
    PATTERN "*.inl"
)

get_property(SFML_INSTALLED_MODULES DIRECTORY "${SFML_SOURCE_DIR}" PROPERTY SFML_MODULES)

configure_file(cmake/SFMLConfig.cmake.in SFMLConfig.cmake @ONLY)

write_basic_package_version_file(
    SFMLConfigVersion.cmake
    COMPATIBILITY SameMajorVersion
)

install(
    FILES
    "${SFML_BINARY_DIR}/SFMLConfig.cmake"
    "${SFML_BINARY_DIR}/SFMLConfigVersion.cmake"
    DESTINATION "${SFML_INSTALL_CMAKEDIR}"
)

include(CPack)
