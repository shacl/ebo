cmake_minimum_required(VERSION 3.12.1)
include_guard(GLOBAL)

add_library(shacl::cmake::Fortran::NoBackslashEscape INTERFACE IMPORTED GLOBAL)

include(Fortran/NoBackslashEscape/Flang)
include(Fortran/NoBackslashEscape/PGI)

# These aliases are provided for short term backwards compatability.
#
# Please don't not use in new work and update existing work to use the
# the imported target defined above as soon as reasonably possible.

add_library(Fortran_NoBackslashEscape ALIAS shacl::cmake::Fortran::NoBackslashEscape)
add_library(Fortran::NoBackslashEscape ALIAS shacl::cmake::Fortran::NoBackslashEscape)

install(FILES
  ${CMAKE_CURRENT_LIST_DIR}/NoBackslashEscape.cmake
  DESTINATION share/cmake/shacl/.cmake/Fortran)
