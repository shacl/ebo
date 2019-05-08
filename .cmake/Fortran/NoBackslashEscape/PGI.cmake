cmake_minimum_required(VERSION 3.12.1)
target_compile_options(shacl::cmake::Fortran::NoBackslashEscape INTERFACE
  $<$<STREQUAL:PGI,${CMAKE_Fortran_COMPILER_ID}>:-Mbackslash>
)
