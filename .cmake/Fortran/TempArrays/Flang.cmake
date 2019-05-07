cmake_minimum_required(VERSION 3.12.1)
string(CONCAT generator
  "$<$<STREQUAL:Flang,${CMAKE_Fortran_COMPILER_ID}>"
    ":$<$<BOOL:$<TARGET_PROPERTY:Fortran_TEMP_ARRAY_THRESHOLD>>"
      ":-fmax-stack-var-size=$<TARGET_PROPERTY:Fortran_TEMP_ARRAY_THRESHOLD>000"
    ">"
  ">"
)

target_compile_options(shacl::cmake::Fortran::TempArrays INTERFACE ${generator})
