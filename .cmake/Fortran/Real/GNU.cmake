cmake_minimum_required(VERSION 3.12.1)
string(CONCAT generator
  "$<$<STREQUAL:${CMAKE_Fortran_COMPILER_ID},GNU>:"
    "$<$<STREQUAL:$<TARGET_PROPERTY:Fortran_REAL_SIZE_BYTES>,8>:-fdefault-real-8;-fdefault-double-8>"
  ">"
)

target_compile_options(shacl::cmake::Fortran::Real_Fortran INTERFACE ${generator})

string(CONCAT generator
  "$<$<STREQUAL:${CMAKE_Fortran_COMPILER_ID},GNU>:"
    "$<$<NOT:$<BOOL:$<TARGET_PROPERTY:Fortran_REAL_SIZE_BYTES>>>:F90_REAL_4BYTE>"
  ">"
)

target_compile_definitions(shacl::cmake::Fortran::Real_C INTERFACE ${generator})

unset(generator)
