if(NOT (SFML_OS_ANDROID OR SFML_OS_IOS OR SFML_OS_WINDOWS))
    return()
endif()

sfml_add_library(Main STATIC)

sfml_define_src_inc_variables()

if(SFML_OS_WINDOWS)
    sfml_target_sources(sfml-main GROUP "" FILES ${src}/MainWin32.cpp)
elseif(SFML_OS_IOS)
    enable_language(OBJCXX)
    sfml_target_sources(sfml-main GROUP "" FILES ${src}/MainiOS.mm)
elseif(SFML_OS_ANDROID)
    sfml_target_sources(sfml-main GROUP "" FILES ${src}/MainAndroid.cpp)
    target_include_directories(sfml-main SYSTEM PRIVATE "${SFML_SOURCE_DIR}/src/glad")

    # because of a current limitation on Android (which prevents one library
    # from depending on shared libraries), we need a boostrap activity which
    # will load our shared libraries manually
    sfml_add_library(Activity)
    sfml_target_sources(sfml-activity GROUP "" FILES ${src}/SFMLActivity.cpp)
    if(CMAKE_ANDROID_STL_TYPE MATCHES "_shared\$")
        target_compile_definitions(sfml-activity PRIVATE "STL_LIBRARY=\"${CMAKE_ANDROID_STL_TYPE}\"")
    endif()

    # android and log: provided by the system
    target_link_libraries(sfml-activity PRIVATE android log)
endif()
