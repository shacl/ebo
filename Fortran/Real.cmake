include(Backports/IncludeGuard)
include_guard(GLOBAL)

define_property(TARGET PROPERTY Fortran_REAL_SIZE_BYTES
  BRIEF_DOCS "the size of the default Fortran real in bytes"
  FULL_DOCS "This property specifies the size in bytes of the default Fortran real, e.g., in the expression 'real :: r' where no kind is given"
)

add_library(Fortran_Real_C INTERFACE)
target_compile_definitions(Fortran_Real_C INTERFACE
  $<$<STREQUAL:$<TARGET_PROPERTY:Fortran_REAL_SIZE_BYTES>,4>:F90_REAL_4BYTE>
  $<$<STREQUAL:$<TARGET_PROPERTY:Fortran_REAL_SIZE_BYTES>,8>:F90_REAL_8BYTE>)
set_property(TARGET Fortran_Real_C APPEND PROPERTY COMPATIBLE_INTERFACE_STRING Fortran_REAL_SIZE_BYTES)

add_library(Fortran_Real_CXX INTERFACE)
target_link_libraries(Fortran_Real_CXX INTERFACE Fortran_Real_C)
set_property(TARGET Fortran_Real_CXX APPEND PROPERTY COMPATIBLE_INTERFACE_STRING Fortran_REAL_SIZE_BYTES)

add_library(Fortran_Real_Fortran INTERFACE)
target_link_libraries(Fortran_Real_Fortran INTERFACE Fortran_Real_C)
set_property(TARGET Fortran_Real_Fortran APPEND PROPERTY COMPATIBLE_INTERFACE_STRING Fortran_REAL_SIZE_BYTES)

include(Fortran/Real/GNU)
include(Fortran/Real/Flang)
include(Fortran/Real/PGI)
include(Fortran/Real/Intel)

add_library(Fortran::Real_C ALIAS Fortran_Real_C)
add_library(Fortran::Real_CXX ALIAS Fortran_Real_CXX)
add_library(Fortran::Real_Fortran ALIAS Fortran_Real_Fortran)
