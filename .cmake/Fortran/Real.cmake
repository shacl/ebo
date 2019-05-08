cmake_minimum_required(VERSION 3.12.1)
include_guard(GLOBAL)

define_property(TARGET PROPERTY Fortran_REAL_SIZE_BYTES
  BRIEF_DOCS "the size of the default Fortran real in bytes"
  FULL_DOCS "This property specifies the size in bytes of the default Fortran real, e.g., in the expression 'real :: r' where no kind is given"
)

add_library(shacl::cmake::Fortran::Real_C INTERFACE IMPORTED GLOBAL)
target_compile_definitions(shacl::cmake::Fortran::Real_C INTERFACE
  $<$<STREQUAL:$<TARGET_PROPERTY:Fortran_REAL_SIZE_BYTES>,4>:F90_REAL_4BYTE>
  $<$<STREQUAL:$<TARGET_PROPERTY:Fortran_REAL_SIZE_BYTES>,8>:F90_REAL_8BYTE>)
set_property(TARGET shacl::cmake::Fortran::Real_C
  APPEND PROPERTY COMPATIBLE_INTERFACE_STRING Fortran_REAL_SIZE_BYTES)

add_library(shacl::cmake::Fortran::Real_CXX INTERFACE IMPORTED GLOBAL)
target_link_libraries(shacl::cmake::Fortran::Real_CXX
  INTERFACE shacl::cmake::Fortran::Real_C)
set_property(TARGET shacl::cmake::Fortran::Real_CXX
  APPEND PROPERTY COMPATIBLE_INTERFACE_STRING Fortran_REAL_SIZE_BYTES)

add_library(shacl::cmake::Fortran::Real_Fortran INTERFACE IMPORTED GLOBAL)
target_link_libraries(shacl::cmake::Fortran::Real_Fortran
  INTERFACE shacl::cmake::Fortran::Real_C)
set_property(TARGET shacl::cmake::Fortran::Real_Fortran
  APPEND PROPERTY COMPATIBLE_INTERFACE_STRING Fortran_REAL_SIZE_BYTES)

include(Fortran/Real/GNU)
include(Fortran/Real/Flang)
include(Fortran/Real/PGI)
include(Fortran/Real/Intel)

# These aliases are provided for short term backwards compatability.
#
# Please don't not use in new work and update existing work to use the
# the imported target defined above as soon as reasonably possible.

add_library(Fortran_Real_C ALIAS shacl::cmake::Fortran::Real_C)
add_library(Fortran::Real_C ALIAS shacl::cmake::Fortran::Real_C)

add_library(Fortran_Real_CXX ALIAS shacl::cmake::Fortran::Real_CXX)
add_library(Fortran::Real_CXX ALIAS shacl::cmake::Fortran::Real_CXX)

add_library(Fortran_Real_Fortran ALIAS shacl::cmake::Fortran::Real_Fortran)
add_library(Fortran::Real_Fortran ALIAS shacl::cmake::Fortran::Real_Fortran)

install(FILES
  ${CMAKE_CURRENT_LIST_DIR}/Real.cmake
  DESTINATION share/cmake/shacl/.cmake/Fortran)

install(DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/Real
  DESTINATION share/cmake/shacl/.cmake/Fortran)
