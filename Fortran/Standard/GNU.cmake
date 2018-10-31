string(CONCAT generator
  "$<$<STREQUAL:$<TARGET_PROPERTY:Fortran_STANDARD>,95>:f95>"
  "$<$<STREQUAL:$<TARGET_PROPERTY:Fortran_STANDARD>,2003>:f2003>"
  "$<$<STREQUAL:$<TARGET_PROPERTY:Fortran_STANDARD>,2008>:f2008>")

string(CONCAT generator
  "$<$<STREQUAL:GNU,${CMAKE_Fortran_COMPILER_ID}>:-std=${generator}>")

target_compile_options(Fortran_Standard INTERFACE ${generator})
