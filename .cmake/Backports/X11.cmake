cmake_minimum_required(VERSION 3.12.1)
include_guard(GLOBAL)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/X11")

install(FILES
  ${CMAKE_CURRENT_LIST_DIR}/X11.cmake
  DESTINATION share/cmake/shacl/.cmake/Backports)

install(DIRECTORY
  ${CMAKE_CURRENT_LIST_DIR}/X11
  DESTINATION share/cmake/shacl/.cmake/Backports)
