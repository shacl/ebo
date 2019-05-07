cmake_minimum_required(VERSION 3.12.1)
string(CONCAT generator
  "$<$<STREQUAL:${CMAKE_Fortran_COMPILER_ID},Intel>:"
    "$<$<NOT:$<PLATFORM_ID:Windows>>:"
      "$<$<STREQUAL:$<TARGET_PROPERTY:Fortran_REAL_SIZE_BYTES>,8>:-r8>"
    ">"
    "$<$<PLATFORM_ID:Windows>:"
      "$<$<STREQUAL:$<TARGET_PROPERTY:Fortran_REAL_SIZE_BYTES>,4>:/real-size:32>"
      "$<$<STREQUAL:$<TARGET_PROPERTY:Fortran_REAL_SIZE_BYTES>,8>:/real-size:64>"
    ">"
  ">"
)

target_compile_options(shacl::cmake::Fortran::Real_Fortran INTERFACE ${generator})

string(CONCAT generator
  "$<$<STREQUAL:${CMAKE_Fortran_COMPILER_ID},Intel>:"
    "$<$<NOT:$<BOOL:$<TARGET_PROPERTY:Fortran_REAL_SIZE_BYTES>>>:F90_REAL_4BYTE>"
  ">"
)

target_compile_definitions(shacl::cmake::Fortran::Real_C INTERFACE ${generator})

unset(generator)
