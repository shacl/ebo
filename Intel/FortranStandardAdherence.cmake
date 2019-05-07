cmake_minimum_required(VERSION 3.12.1)
include_guard(GLOBAL)

include(Intel/FortranAssumptions)

# Standard-semantics options for Intel
add_library(shacl::cmake::Intel::Fortran::StandardAdherence
  INTERFACE IMPORTED GLOBAL)

# These aliases are provided for short term backwards compatability.
#
# Please don't not use in new work and update existing work to use the
# the imported target defined above as soon as reasonably possible.
#
add_library(Intel::FortranStandardAdherence ALIAS
  shacl::cmake::Intel::Fortran::StandardAdherence)

add_library(Intel_Fortran_StandardAdherence ALIAS
  shacl::cmake::Intel::Fortran::StandardAdherence)

set_target_properties(shacl::cmake::Intel::Fortran::StandardAdherence PROPERTIES
  INTERFACE_Intel_Fortran_DISABLED_ASSUMPTIONS std_mod_proc_name)

set_property(TARGET shacl::cmake::Intel::Fortran::StandardAdherence APPEND
  PROPERTY COMPATIBLE_INTERFACE_STRING Intel_Fortran_DISABLED_ASSUMPTIONS)

string(CONCAT generator
  "$<$<STREQUAL:Intel,${CMAKE_Fortran_COMPILER_ID}>:"
      "$<$<NOT:$<PLATFORM_ID:Windows>>:-standard-semantics;>"
          "$<$<PLATFORM_ID:Windows>:/standard-semantics;>>")

target_compile_options(shacl::cmake::Intel::Fortran::StandardAdherence
  INTERFACE ${generator})

target_link_libraries(shacl::cmake::Intel::Fortran::StandardAdherence
  INTERFACE shacl::cmake::Intel::Fortran::Assumptions)

install(FILES
  ${CMAKE_CURRENT_LIST_DIR}/FortranStandardAdherence.cmake
  DESTINATION share/cmake/shacl/.cmake/Intel)
