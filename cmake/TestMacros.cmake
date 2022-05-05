function(sfml_add_test target)
    cmake_parse_arguments(PARSE_ARGV 1 THIS "" "" "FILES;DEPENDS")

    add_executable("${target}")
    sfml_target_sources("${target}" GROUP "" FILES "${THIS_FILES}")
    set_property(TARGET "${target}" PROPERTY FOLDER Tests)
    if(DEFINED THIS_DEPENDS)
        target_link_libraries("${target}" PRIVATE ${THIS_DEPENDS})
    endif()

    doctest_discover_tests("${target}")
endfunction()
