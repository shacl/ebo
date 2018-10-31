# PGI cannot check for particular standard, so we check for general standard 
# compliance

string(CONCAT generator
  "$<$<STREQUAL:PGI,${CMAKE_Fortran_COMPILER_ID}>:-Mstandard>"
  )

target_compile_options(Fortran_Standard INTERFACE ${generator})
