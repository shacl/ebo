cmake_minimum_required(VERSION 3.12.1)
string(CONCAT generator
  "$<$<STREQUAL:${CMAKE_Fortran_COMPILER_ID},Intel>:"
    "$<$<NOT:$<PLATFORM_ID:Windows>>:"
      "$<$<STREQUAL:$<TARGET_PROPERTY:Fortran_INTEGER_SIZE_BYTES>,8>:-i8>"
    ">"
    "$<$<PLATFORM_ID:Windows>:"
      "$<$<STREQUAL:$<TARGET_PROPERTY:Fortran_INTEGER_SIZE_BYTES>,4>:/integer-size:32>"
      "$<$<STREQUAL:$<TARGET_PROPERTY:Fortran_INTEGER_SIZE_BYTES>,8>:/integer-size:64>"
    ">"
  ">"
)

target_compile_options(shacl::cmake::Fortran::Integer_Fortran INTERFACE ${generator})

string(CONCAT generator
  "$<$<STREQUAL:${CMAKE_Fortran_COMPILER_ID},Intel>:"
    "$<$<NOT:$<BOOL:$<TARGET_PROPERTY:Fortran_INTEGER_SIZE_BYTES>>>:F90_INT_4BYTE>"
  ">"
)

target_compile_definitions(shacl::cmake::Fortran::Integer_C INTERFACE ${generator})

unset(generator)
