cmake_minimum_required(VERSION 3.12.1)
check_language(C)
if(DEFINED CMAKE_C_COMPILER)
  add_library(shacl::cmake::Warnings_C INTERFACE IMPORTED GLOBAL)
  include(Warnings/C/GNU)
  include(Warnings/C/LLVM)
  include(Warnings/C/MSVC)
  include(Warnings/C/Intel)

# These aliases are provided for short term backwards compatability.
#
# Please don't not use in new work and update existing work to use the
# the imported target defined above as soon as reasonably possible.
#
  add_library(Warnings_C ALIAS shacl::cmake::Warnings_C)
  add_library(Warnings::Warnings_C ALIAS shacl::cmake::Warnings_C)
endif()
