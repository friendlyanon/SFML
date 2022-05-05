cmake_minimum_required(VERSION 3.16)

list(JOIN examples "\n" examples)
execute_process(COMMAND "${CMAKE_COMMAND}" -E echo "Example targets are:\n\n${examples}")
