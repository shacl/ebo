cmake_minimum_required(VERSION 3.12.1)
include_guard(GLOBAL)

define_property(TARGET PROPERTY Fortran_BACKTRACE
BRIEF_DOCS
"Toggle backtrace information in Fortran programs"
FULL_DOCS
"This functionality is not universally supported amongst Fortran 
 compilers. This property provides an interface to that functionality
 if available.")

add_library(shacl::cmake::Fortran::Backtrace INTERFACE IMPORTED GLOBAL)

include(Fortran/Backtrace/Intel)
include(Fortran/Backtrace/PGI)
include(Fortran/Backtrace/GNU)
# traceback with Flang is default

# These aliases are provided for short term backwards compatability.
#
# Please don't not use in new work and update existing work to use the
# the imported target defined above as soon as reasonably possible.

add_library(Fortran_Backtrace ALIAS shacl::cmake::Fortran::Backtrace)
add_library(Fortran::Backtrace ALIAS shacl::cmake::Fortran::Backtrace)

install(FILES
  ${CMAKE_CURRENT_LIST_DIR}/Backtrace.cmake
  DESTINATION share/cmake/shacl/.cmake/Fortran)

install(DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/Backtrace
  DESTINATION share/cmake/shacl/.cmake/Fortran)
