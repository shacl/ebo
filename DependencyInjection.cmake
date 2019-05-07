cmake_minimum_required(VERSION 3.12.1)
include_guard(GLOBAL)

include(FunctionExtension)

include(DependencyInjection/add_executable)
include(DependencyInjection/add_library)

install(FILES
  ${CMAKE_CURRENT_LIST_DIR}/DependencyInjection.cmake
  DESTINATION share/cmake/shacl/.cmake)
