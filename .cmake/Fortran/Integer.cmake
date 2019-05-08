cmake_minimum_required(VERSION 3.12.1)
include_guard(GLOBAL)

define_property(TARGET PROPERTY Fortran_INTEGER_SIZE_BYTES
  BRIEF_DOCS "the size of the default Fortran integer in bytes"
  FULL_DOCS "This property specifies the size in bytes of the default Fortran integer, e.g., in the expression 'integer :: i' where no kind is given"
)

add_library(shacl::cmake::Fortran::Integer_C INTERFACE IMPORTED GLOBAL)
target_compile_definitions(shacl::cmake::Fortran::Integer_C INTERFACE
  $<$<STREQUAL:$<TARGET_PROPERTY:Fortran_INTEGER_SIZE_BYTES>,4>:F90_INT_4BYTE>
  $<$<STREQUAL:$<TARGET_PROPERTY:Fortran_INTEGER_SIZE_BYTES>,8>:F90_INT_8BYTE>)
set_property(TARGET shacl::cmake::Fortran::Integer_C 
  APPEND PROPERTY COMPATIBLE_INTERFACE_STRING Fortran_INTEGER_SIZE_BYTES)

add_library(shacl::cmake::Fortran::Integer_CXX INTERFACE IMPORTED GLOBAL)
target_link_libraries(shacl::cmake::Fortran::Integer_CXX
  INTERFACE shacl::cmake::Fortran::Integer_C)
set_property(TARGET shacl::cmake::Fortran::Integer_CXX
  APPEND PROPERTY COMPATIBLE_INTERFACE_STRING Fortran_INTEGER_SIZE_BYTES)

add_library(shacl::cmake::Fortran::Integer_Fortran INTERFACE IMPORTED GLOBAL)
target_link_libraries(shacl::cmake::Fortran::Integer_Fortran
  INTERFACE shacl::cmake::Fortran::Integer_C)
set_property(TARGET shacl::cmake::Fortran::Integer_Fortran
  APPEND PROPERTY COMPATIBLE_INTERFACE_STRING Fortran_INTEGER_SIZE_BYTES)

include(Fortran/Integer/GNU)
include(Fortran/Integer/Flang)
include(Fortran/Integer/PGI)
include(Fortran/Integer/Intel)

# These aliases are provided for short term backwards compatability.
#
# Please don't not use in new work and update existing work to use the
# the imported target defined above as soon as reasonably possible.

add_library(Fortran_Integer_C ALIAS shacl::cmake::Fortran::Integer_C)
add_library(Fortran::Integer_C ALIAS shacl::cmake::Fortran::Integer_C)

add_library(Fortran_Integer_CXX ALIAS shacl::cmake::Fortran::Integer_CXX)
add_library(Fortran::Integer_CXX ALIAS shacl::cmake::Fortran::Integer_CXX)

add_library(Fortran_Integer_Fortran ALIAS shacl::cmake::Fortran::Integer_Fortran)
add_library(Fortran::Integer_Fortran ALIAS shacl::cmake::Fortran::Integer_Fortran)

install(FILES
  ${CMAKE_CURRENT_LIST_DIR}/Integer.cmake
  DESTINATION share/cmake/shacl/.cmake/Fortran)

install(DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/Integer
  DESTINATION share/cmake/shacl/.cmake/Fortran)
