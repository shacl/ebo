cmake_minimum_required(VERSION 3.12.1)
string(CONCAT generator
  "$<$<STREQUAL:GNU,${CMAKE_Fortran_COMPILER_ID}>:"
     "$<$<BOOL:$<TARGET_PROPERTY:Fortran_BACKTRACE>>:-fbacktrace>;"
     "$<$<NOT:$<BOOL:$<TARGET_PROPERTY:Fortran_BACKTRACE>>>:-fno-backtrace>;"
   ">")

target_compile_options(shacl::cmake::Fortran::Backtrace INTERFACE ${generator})
