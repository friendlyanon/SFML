sfml_add_library(System)

sfml_define_src_inc_variables()

sfml_target_sources(
    sfml-system GROUP "" FILES
    ${inc}/Angle.hpp
    ${inc}/Angle.inl
    ${src}/Clock.cpp
    ${inc}/Clock.hpp
    ${src}/Err.cpp
    ${inc}/Err.hpp
    ${inc}/Export.hpp
    ${inc}/InputStream.hpp
    ${inc}/NativeActivity.hpp
    ${src}/Sleep.cpp
    ${inc}/Sleep.hpp
    ${src}/String.cpp
    ${inc}/String.hpp
    ${inc}/String.inl
    ${inc}/Time.hpp
    ${inc}/Time.inl
    ${inc}/Utf.hpp
    ${inc}/Utf.inl
    ${src}/Vector2.cpp
    ${inc}/Vector2.hpp
    ${inc}/Vector2.inl
    ${src}/Vector3.cpp
    ${inc}/Vector3.hpp
    ${inc}/Vector3.inl
    ${src}/FileInputStream.cpp
    ${inc}/FileInputStream.hpp
    ${src}/MemoryInputStream.cpp
    ${inc}/MemoryInputStream.hpp
    ${inc}/SuspendAwareClock.hpp
)

if(SFML_OS_WINDOWS)
    sfml_target_sources(
        sfml-system GROUP windows FILES
        ${src}/Win32/SleepImpl.cpp
        ${src}/Win32/SleepImpl.hpp
    )
else()
    sfml_target_sources(
        sfml-system GROUP unix FILES
        ${src}/Unix/SleepImpl.cpp
        ${src}/Unix/SleepImpl.hpp
    )

    if(SFML_OS_ANDROID)
        sfml_target_sources(
            sfml-system GROUP unix FILES
            ${src}/Android/Activity.hpp
            ${src}/Android/Activity.cpp
            ${src}/Android/NativeActivity.cpp
            ${src}/Android/ResourceStream.cpp
            ${src}/Android/ResourceStream.cpp
            ${src}/Android/SuspendAwareClock.cpp
        )
    endif()
endif()

if(SFML_OS_ANDROID)
    target_include_directories(sfml-window SYSTEM PRIVATE "${SFML_SOURCE_DIR}/src/glad")
endif()

find_package(Threads REQUIRED)
target_link_libraries(sfml-system PRIVATE Threads::Threads)

if(SFML_OS_LINUX)
    # rt: provided by the system
    target_link_libraries(sfml-system PRIVATE rt)
elseif(SFML_OS_WINDOWS)
    # winmm: provided by the system (Windows SDK)
    target_link_libraries(sfml-system PRIVATE winmm)
elseif(SFML_OS_ANDROID)
    # android and log: provided by the system
    target_link_libraries(sfml-system PRIVATE android log)
endif()
