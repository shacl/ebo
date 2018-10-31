string(CONCAT generator
  "$<$<STREQUAL:PGI,${CMAKE_Fortran_COMPILER_ID}>:"
    "$<$<BOOL:$<TARGET_PROPERTY:Fortran_BACKTRACE>>:-traceback>;"
    "$<$<NOT:$<BOOL:$<TARGET_PROPERTY:Fortran_BACKTRACE>>>:-notraceback>;"
  ">"
)

target_compile_options(Fortran_Backtrace INTERFACE ${generator})
