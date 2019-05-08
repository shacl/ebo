cmake_minimum_required(VERSION 3.12.1)
string(CONCAT generator
  "$<$<STREQUAL:PGI,${CMAKE_Fortran_COMPILER_ID}>:"
    "$<$<BOOL:$<TARGET_PROPERTY:Fortran_BACKTRACE>>:-traceback>;"
    "$<$<NOT:$<BOOL:$<TARGET_PROPERTY:Fortran_BACKTRACE>>>:-notraceback>;"
  ">"
)

target_compile_options(shacl::cmake::Fortran::Backtrace INTERFACE ${generator})
