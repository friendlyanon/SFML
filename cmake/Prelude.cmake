if(NOT CMAKE_CURRENT_SOURCE_DIR STREQUAL CMAKE_SOURCE_DIR)
    message(
        FATAL_ERROR
        "SFML does not support vendoring. "
        "Acquire SFML using a package manager or build the project and use its install artifacts via find_package(). "
        "Read the BUILDING document for more details."
    )
endif()

if(CMAKE_SOURCE_DIR STREQUAL CMAKE_BINARY_DIR)
    message(
        FATAL_ERROR
        "In-source builds are not supported. "
        "Please read the BUILDING document before trying to build this project. "
        "You may need to delete 'CMakeCache.txt' and 'CMakeFiles/' first."
    )
endif()
