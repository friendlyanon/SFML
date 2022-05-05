# Use this script via setting the CMAKE_PROJECT_SFMLTests_INCLUDE cache
# variable to the path of this script

include(ProcessorCount)
ProcessorCount(N)

file(MAKE_DIRECTORY "${SFML_BINARY_DIR}/coverage.out")

# Convert delimiters to Windows ones
string(REPLACE "/" "\\" binary_dir "${SFML_BINARY_DIR}")
string(REPLACE "/" "\\" source_dir "${SFML_SOURCE_DIR}")
string(REPLACE "/" "\\" ctest "${CMAKE_CTEST_COMMAND}")

add_custom_target(
    win-cov
    COMMAND OpenCppCoverage -q
    # We want coverage from the child processes of CTest
    --cover_children
    # Subdirectory where the tests reside in the binary directory
    --modules "${binary_dir}\\test"
    # Export results as the cobertura XML format
    --export_type "cobertura:${binary_dir}\\coverage.out"
    # Source file locations
    --sources "${source_dir}\\src"
    --sources "${source_dir}\\include"
    --sources "${source_dir}\\test"
    # Working directory for CTest, which should be the binary directory
    --working_dir "${binary_dir}"
    # OpenCppCoverage should be run only with the Debug configuration tests
    -- "${ctest}" -C "\$<CONFIG>" --output-on-failure -j "${N}"
    WORKING_DIRECTORY "${SFML_BINARY_DIR}"
    VERBATIM
)
