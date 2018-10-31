target_compile_options(Fortran_TempArrays INTERFACE
  "$<$<STREQUAL:PGI,${CMAKE_Fortran_COMPILER_ID}>:-Mnostack_arrays>")
