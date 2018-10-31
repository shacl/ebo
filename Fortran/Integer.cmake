include(Backports/IncludeGuard)
include_guard(GLOBAL)

define_property(TARGET PROPERTY Fortran_INTEGER_SIZE_BYTES
  BRIEF_DOCS "the size of the default Fortran integer in bytes"
  FULL_DOCS "This property specifies the size in bytes of the default Fortran integer, e.g., in the expression 'integer :: i' where no kind is given"
)

add_library(Fortran_Integer_C INTERFACE)
target_compile_definitions(Fortran_Integer_C INTERFACE
  $<$<STREQUAL:$<TARGET_PROPERTY:Fortran_INTEGER_SIZE_BYTES>,4>:F90_INT_4BYTE>
  $<$<STREQUAL:$<TARGET_PROPERTY:Fortran_INTEGER_SIZE_BYTES>,8>:F90_INT_8BYTE>)
set_property(TARGET Fortran_Integer_C APPEND PROPERTY COMPATIBLE_INTERFACE_STRING Fortran_INTEGER_SIZE_BYTES)

add_library(Fortran_Integer_CXX INTERFACE)
target_link_libraries(Fortran_Integer_CXX INTERFACE Fortran_Integer_C)
set_property(TARGET Fortran_Integer_CXX APPEND PROPERTY COMPATIBLE_INTERFACE_STRING Fortran_INTEGER_SIZE_BYTES)

add_library(Fortran_Integer_Fortran INTERFACE)
target_link_libraries(Fortran_Integer_Fortran INTERFACE Fortran_Integer_C)
set_property(TARGET Fortran_Integer_Fortran APPEND PROPERTY COMPATIBLE_INTERFACE_STRING Fortran_INTEGER_SIZE_BYTES)

include(Fortran/Integer/GNU)
include(Fortran/Integer/Flang)
include(Fortran/Integer/PGI)
include(Fortran/Integer/Intel)

add_library(Fortran::Integer_C ALIAS Fortran_Integer_C)
add_library(Fortran::Integer_CXX ALIAS Fortran_Integer_CXX)
add_library(Fortran::Integer_Fortran ALIAS Fortran_Integer_Fortran)
