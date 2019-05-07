cmake_minimum_required(VERSION 3.12.1)
include_guard(GLOBAL)

set_property(GLOBAL PROPERTY USE_FOLDERS ON)

include(FunctionExtension)
include(GeneratedSources/ListBinaryDir)
include(GeneratedSources/add_library)
include(GeneratedSources/add_executable)
include(GeneratedSources/target_sources)

install(FILES
  ${CMAKE_CURRENT_LIST_DIR}/GeneratedSources.cmake
  DESTINATION share/cmake/shacl/.cmake)

install(DIRECTORY
  ${CMAKE_CURRENT_LIST_DIR}/GeneratedSources
  DESTINATION share/cmake/shacl/.cmake)
