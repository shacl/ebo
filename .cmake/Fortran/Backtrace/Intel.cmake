string(CONCAT generator
  "$<$<STREQUAL:Intel,${CMAKE_Fortran_COMPILER_ID}>:"
    "$<$<BOOL:$<TARGET_PROPERTY:Fortran_BACKTRACE>>:"
      "$<$<PLATFORM_ID:Windows>:/traceback>;"
      "$<$<NOT:$<PLATFORM_ID:Windows>>:-traceback>;"
    ">"
    "$<$<NOT:$<BOOL:$<TARGET_PROPERTY:Fortran_BACKTRACE>>>:"
      "$<$<PLATFORM_ID:Windows>:/notraceback>;"
      "$<$<NOT:$<PLATFORM_ID:Windows>>:-notraceback>;"
    ">"
  ">"
)

target_compile_options(Fortran_Backtrace INTERFACE ${generator})
