cmake_minimum_required(VERSION 3.12.1)
check_language(Fortran)
if(DEFINED CMAKE_Fortran_COMPILER)
  add_library(shacl::cmake::Warnings_Fortran INTERFACE IMPORTED GLOBAL)
  include(Warnings/Fortran/GNU)
  include(Warnings/Fortran/Intel)

# These aliases are provided for short term backwards compatability.
#
# Please don't not use in new work and update existing work to use the
# the imported target defined above as soon as reasonably possible.
#
  add_library(Warnings_Fortran ALIAS shacl::cmake::Warnings_Fortran)
  add_library(Warnings::Warnings_Fortran ALIAS shacl::cmake::Warnings_Fortran)
endif()
