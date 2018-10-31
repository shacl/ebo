target_compile_options(Fortran_NoBackslashEscape INTERFACE
  $<$<STREQUAL:PGI,${CMAKE_Fortran_COMPILER_ID}>:-Mbackslash>
)
