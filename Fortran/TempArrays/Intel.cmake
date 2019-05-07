cmake_minimum_required(VERSION 3.12.1)
string(CONCAT generator
  "$<$<STREQUAL:Intel,${CMAKE_Fortran_COMPILER_ID}>:"
    "$<$<BOOL:$<TARGET_PROPERTY:Fortran_TEMP_ARRAY_THRESHOLD>>:"
      "$<$<NOT:$<PLATFORM_ID:Windows>>:-heap-arrays;$<TARGET_PROPERTY:Fortran_TEMP_ARRAY_THRESHOLD>>"
      "$<$<PLATFORM_ID:Windows>:/heap-arrays:$<TARGET_PROPERTY:Fortran_TEMP_ARRAY_THRESHOLD>>"
    ">"
  ">"
)

target_compile_options(shacl::cmake::Fortran::TempArrays INTERFACE ${generator})
