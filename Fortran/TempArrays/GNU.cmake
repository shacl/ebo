string(CONCAT generator
  "$<$<STREQUAL:GNU,${CMAKE_Fortran_COMPILER_ID}>"
    ":$<$<BOOL:$<TARGET_PROPERTY:Fortran_TEMP_ARRAY_THRESHOLD>>"
      ":-fmax-stack-var-size=$<TARGET_PROPERTY:Fortran_TEMP_ARRAY_THRESHOLD>000"
    ">"
  ">"
)

target_compile_options(Fortran_TempArrays INTERFACE ${generator})
