cmake_minimum_required(VERSION 3.12.1)
set_property( GLOBAL PROPERTY FIND_LIBRARY_USE_LIB64_PATHS ON )

include(Backports/X11)

install(FILES
  ${CMAKE_CURRENT_LIST_DIR}/Backports.cmake
  DESTINATION share/cmake/shacl/.cmake)
