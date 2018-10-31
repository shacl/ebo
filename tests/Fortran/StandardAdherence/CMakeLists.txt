include(Fortran)

file(GENERATE 
  OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/use_fortran_standard_adherence.f90
  INPUT ${CMAKE_CURRENT_LIST_DIR}/use_fortran_standard_adherence.F90.in)

add_executable(fortran_standard_adherence ${CMAKE_CURRENT_BINARY_DIR}/use_fortran_standard_adherence.f90)
target_link_libraries(fortran_standard_adherence PUBLIC Fortran::StandardAdherence)

set(expected_PGI "-Mbackslash\n")
set(expected_Intel "-standard-semantics -assume nostd_mod_proc_name\n")
if( WIN32 )
  set(expected_Intel "/standard-semantics /assume:nostd_mod_proc_name\n")
endif()

set(expected "${expected_${CMAKE_Fortran_COMPILER_ID}}")

add_test(NAME Fortran.StandardAdherence
  COMMAND fortran_standard_adherence)

set_tests_properties(Fortran.StandardAdherence PROPERTIES
  PASS_REGULAR_EXPRESSION "^${expected}$")
