cmake_minimum_required(VERSION 3.2.0)
project(shacl_cmake LANGUAGES Fortran VERSION 1.0.0)

include(CTest)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/../../..)

include(FunctionExtension)

backup(set_target_properties)

function(set_target_properties)
  previous_set_target_properties(${ARGN})
  file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/sink1" "${ARGN}")
endfunction()

backup(set_target_properties)

function(set_target_properties)
  previous_set_target_properties(${ARGN})
  file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/sink2" "${ARGN}")
endfunction()

add_library(foo INTERFACE)

set_target_properties(foo PROPERTIES INTERFACE_bar hello)

add_test(NAME set_target_properties_extension
  COMMAND ${CMAKE_COMMAND} -E compare_files "${CMAKE_CURRENT_BINARY_DIR}/sink1" "${CMAKE_CURRENT_BINARY_DIR}/sink2")

