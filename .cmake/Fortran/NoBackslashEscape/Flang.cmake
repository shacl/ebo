target_compile_options(Fortran_NoBackslashEscape INTERFACE
  $<$<STREQUAL:Flang,${CMAKE_Fortran_COMPILER_ID}>:-fno-backslash>
)
