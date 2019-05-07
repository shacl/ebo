cmake_minimum_required(VERSION 3.12.1)
include_guard(GLOBAL)

define_property(TARGET PROPERTY Intel_Fortran_ENABLED_ASSUMPTIONS
BRIEF_DOCS
"Intel assumption keywords (for Fortran) to ensable"
FULL_DOCS
"This property contains zero or more entries specifying assumption options
 used when compiling with the Intel Fortran compiler. Each entry corresponds
 to an assumption keyword, e.g., specifying `buffered_io` will add the
 `-assume buffered_io` or `/assume:buffered_io` flag as appropriate for
 the host platform.

 Multiple entries must be semicolon separated e.g. unused;unused")

define_property(TARGET PROPERTY Intel_Fortran_DISABLED_ASSUMPTIONS
BRIEF_DOCS
"Intel assumption keywords (for Fortran) to disable"
FULL_DOCS
"This property contains zero or more entries specifying assumption options
 used when compiling with the Intel Fortran compiler. Each entry corresponds
 to an assumption keyword, e.g., specifying `buffered_io` will add the
 `-assume nobuffered_io` or `/assume:nobuffered_io` flag as appropriate for
 the host platform.

 Multiple entries must be semicolon separated e.g. unused;unused")

add_library(shacl::cmake::Intel::Fortran::Assumptions INTERFACE IMPORTED GLOBAL)

# These aliases are provided for short term backwards compatability.
#
# Please don't not use in new work and update existing work to use the
# the imported target defined above as soon as reasonably possible.
#
add_library(Intel::FortranAssumptions ALIAS
  shacl::cmake::Intel::Fortran::Assumptions)

add_library(Intel_Assumptions ALIAS
  shacl::cmake::Intel::Fortran::Assumptions)

string(CONCAT generator
  "$<$<AND:$<STREQUAL:Intel,${CMAKE_Fortran_COMPILER_ID}>"
         ",$<BOOL:$<TARGET_PROPERTY:Intel_Fortran_ENABLED_ASSUMPTIONS>>>:"
    "$<$<PLATFORM_ID:Windows>:/assume:>"
    "$<$<NOT:$<PLATFORM_ID:Windows>>:-assume;>"
    "$<JOIN:$<TARGET_PROPERTY:Intel_Fortran_ENABLED_ASSUMPTIONS>,$<COMMA>>"
  ">"
  "$<$<AND:$<STREQUAL:Intel,${CMAKE_Fortran_COMPILER_ID}>"
         ",$<BOOL:$<TARGET_PROPERTY:Intel_Fortran_DISABLED_ASSUMPTIONS>>>:"
    "$<$<BOOL:$<TARGET_PROPERTY:Intel_Fortran_ENABLED_ASSUMPTIONS>>:$<COMMA>no>"
    "$<$<NOT:$<BOOL:$<TARGET_PROPERTY:Intel_Fortran_ENABLED_ASSUMPTIONS>>>:"
      "$<$<PLATFORM_ID:Windows>:/assume:no>"
      "$<$<NOT:$<PLATFORM_ID:Windows>>:-assume;no>"
    ">"
    "$<JOIN:$<TARGET_PROPERTY:Intel_Fortran_DISABLED_ASSUMPTIONS>,$<COMMA>no>"
  ">;")

target_compile_options(shacl::cmake::Intel::Fortran::Assumptions INTERFACE
  ${generator})

install(FILES
  ${CMAKE_CURRENT_LIST_DIR}/FortranAssumptions.cmake
  DESTINATION share/cmake/shacl/.cmake/Intel)
