cmake_minimum_required(VERSION 3.12.1)
include_guard(GLOBAL)

include(Fortran/NoBackslashEscape)
include(Intel/FortranAssumptions)

add_library(shacl::cmake::Fortran::StandardAdherence INTERFACE IMPORTED GLOBAL)

# These aliases are provided for short term backwards compatability.
#
# Please don't not use in new work and update existing work to use the
# the imported target defined above as soon as reasonably possible.

add_library(Fortran_StandardAdherence ALIAS shacl::cmake::Fortran::StandardAdherence)
add_library(Fortran::StandardAdherence ALIAS shacl::cmake::Fortran::StandardAdherence)

target_link_libraries(shacl::cmake::Fortran::StandardAdherence INTERFACE
  shacl::cmake::Fortran::NoBackslashEscape
  shacl::cmake::Intel::Fortran::StandardAdherence)

install(FILES
  ${CMAKE_CURRENT_LIST_DIR}/StandardAdherence.cmake
  DESTINATION share/cmake/shacl/.cmake/Fortran)
