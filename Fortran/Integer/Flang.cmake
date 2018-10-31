string(CONCAT generator
  "$<$<STREQUAL:${CMAKE_Fortran_COMPILER_ID},Flang>:"
    "$<$<STREQUAL:$<TARGET_PROPERTY:Fortran_INTEGER_SIZE_BYTES>,8>:-fdefault-integer-8>"
  ">"
)

target_compile_options(Fortran_Integer_Fortran INTERFACE ${generator})

string(CONCAT generator
  "$<$<STREQUAL:${CMAKE_Fortran_COMPILER_ID},Flang>:"
    "$<$<NOT:$<BOOL:$<TARGET_PROPERTY:Fortran_INTEGER_SIZE_BYTES>>>:F90_INT_4BYTE>"
  ">"
)

target_compile_definitions(Fortran_Integer_C INTERFACE ${generator})

unset(generator)
