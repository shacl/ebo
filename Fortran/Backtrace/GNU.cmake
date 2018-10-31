string(CONCAT generator
  "$<$<STREQUAL:GNU,${CMAKE_Fortran_COMPILER_ID}>:"
     "$<$<BOOL:$<TARGET_PROPERTY:Fortran_BACKTRACE>>:-fbacktrace>;"
     "$<$<NOT:$<BOOL:$<TARGET_PROPERTY:Fortran_BACKTRACE>>>:-fno-backtrace>;"
   ">")

target_compile_options(Fortran_Backtrace INTERFACE ${generator})
