cmake_minimum_required(VERSION 3.2.0)
project(test_separate_arguments LANGUAGES CXX)
enable_testing()
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/../../..")

include(Backports)

add_executable(test_separate_arguments test.cpp)
separate_arguments(arg_list NATIVE_COMMAND "a b c d")
string(REPLACE ";" "\n" file_contents "${arg_list}")
file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/argument_reference.txt" "${file_contents}")

add_test(NAME test_separate_arguments
  COMMAND test_separate_arguments argument_reference.txt ${arg_list})
