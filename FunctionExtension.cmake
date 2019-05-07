cmake_minimum_required(VERSION 3.12.1)
include_guard(GLOBAL)

include(FunctionExtension/push)
include(FunctionExtension/pop)
include(FunctionExtension/call)
include(FunctionExtension/backup)
include(FunctionExtension/add_library)
include(FunctionExtension/add_executable)
include(FunctionExtension/set_property)
include(FunctionExtension/set_target_properties)
include(FunctionExtension/target_sources)
include(FunctionExtension/find_package)
include(FunctionExtension/set_target_properties)

install(FILES
  ${CMAKE_CURRENT_LIST_DIR}/FunctionExtension.cmake
  DESTINATION share/cmake/shacl/.cmake)

install(DIRECTORY
  ${CMAKE_CURRENT_LIST_DIR}/FunctionExtension
  DESTINATION share/cmake/shacl/.cmake)
