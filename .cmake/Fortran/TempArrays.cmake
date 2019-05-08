cmake_minimum_required(VERSION 3.12.1)
include_guard(GLOBAL)

define_property(TARGET PROPERTY Fortran_TEMP_ARRAY_THRESHOLD
  BRIEF_DOCS
  "A threshold (in kilobytes) above which temporary and automatic arrays should be heap allocated"
  FULL_DOCS
  "A threshold (in kilobytes) above which temporary and automatic arrays should be heap allocated"
)

add_library(shacl::cmake::Fortran::TempArrays INTERFACE IMPORTED GLOBAL)

include(Fortran/TempArrays/GNU)
# include(Fortran/TempArrays/Flang) # not implemented as of 20180716
include(Fortran/TempArrays/Intel)
include(Fortran/TempArrays/PGI)

# These aliases are provided for short term backwards compatability.
#
# Please don't not use in new work and update existing work to use the
# the imported target defined above as soon as reasonably possible.

add_library(Fortran_TempArrays ALIAS shacl::cmake::Fortran::TempArrays)
add_library(Fortran::TempArrays ALIAS shacl::cmake::Fortran::TempArrays)

install(FILES
  ${CMAKE_CURRENT_LIST_DIR}/TempArrays.cmake
  DESTINATION share/cmake/shacl/.cmake/Fortran)

install(DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/TempArrays
  DESTINATION share/cmake/shacl/.cmake/Fortran)
