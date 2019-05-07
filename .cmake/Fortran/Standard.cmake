cmake_minimum_required(VERSION 3.12.1)
include_guard(GLOBAL)

define_property(TARGET PROPERTY Fortran_STANDARD
BRIEF_DOCS
"The Fortran standard whose features are requested to build this target."
FULL_DOCS
"This property specifies the Fortran standard whose features are requested to
 build this target. For some compilers, this results in adding a flag such as
 -std=f2003 to the compile line. For compilers that have no notion of a
 standard level, such as PGI, this has no effect.

 Supported values are 95, 2003, and 2008")

add_library(shacl::cmake::Fortran::Standard INTERFACE IMPORTED GLOBAL)

# These aliases are provided for short term backwards compatability.
#
# Please don't not use in new work and update existing work to use the
# the imported target defined above as soon as reasonably possible.

add_library(Fortran_Standard ALIAS shacl::cmake::Fortran::Standard)
add_library(Fortran::Standard ALIAS shacl::cmake::Fortran::Standard)

include(Fortran/Standard/Intel)
include(Fortran/Standard/GNU)
include(Fortran/Standard/PGI)
# TODO: Flang -- it does not implement standards checking yet

install(FILES
  ${CMAKE_CURRENT_LIST_DIR}/Standard.cmake
  DESTINATION share/cmake/shacl/.cmake/Fortran)

install(DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/Standard
  DESTINATION share/cmake/shacl/.cmake/Fortran)
