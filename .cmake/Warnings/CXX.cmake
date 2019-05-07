cmake_minimum_required(VERSION 3.12.1)

check_language(CXX)
if(DEFINED CMAKE_CXX_COMPILER)
  add_library(shacl::cmake::Warnings_CXX INTERFACE IMPORTED GLOBAL)
  include(Warnings/CXX/GNU)
  include(Warnings/CXX/LLVM)
  include(Warnings/CXX/MSVC)
  include(Warnings/CXX/Intel)

# These aliases are provided for short term backwards compatability.
#
# Please don't not use in new work and update existing work to use the
# the imported target defined above as soon as reasonably possible.
#
  add_library(Warnings_CXX ALIAS shacl::cmake::Warnings_CXX)
  add_library(Warnings::Warnings_CXX ALIAS shacl::cmake::Warnings_CXX)
endif()

