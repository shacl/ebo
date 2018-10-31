include(Fortran)

file(GENERATE OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/use_standard.f90
              INPUT ${CMAKE_CURRENT_LIST_DIR}/use_standard.f90.in)

add_executable(use_standard ${CMAKE_CURRENT_BINARY_DIR}/use_standard.f90)
set_target_properties(use_standard PROPERTIES Fortran_STANDARD 2008)
target_link_libraries(use_standard PRIVATE Fortran::Standard)

add_custom_target(run_use_standard ALL COMMAND use_standard)
add_dependencies(run_use_standard use_standard)

if( WIN32)
  configure_file(${CMAKE_CURRENT_SOURCE_DIR}/terminal_output_${CMAKE_Fortran_COMPILER_ID}_win32
                 ${CMAKE_CURRENT_BINARY_DIR}/terminal_output_${CMAKE_Fortran_COMPILER_ID}_win32
                 NEWLINE_STYLE DOS)

  add_test(NAME run_use_standard
    COMMAND ${CMAKE_COMMAND} -E compare_files
      ${CMAKE_CURRENT_BINARY_DIR}/terminal_output
      ${CMAKE_CURRENT_BINARY_DIR}/terminal_output_${CMAKE_Fortran_COMPILER_ID}_win32)
else()
  add_test(NAME run_use_standard
    COMMAND ${CMAKE_COMMAND} -E compare_files
      ${CMAKE_CURRENT_BINARY_DIR}/terminal_output
      ${CMAKE_CURRENT_SOURCE_DIR}/terminal_output_${CMAKE_Fortran_COMPILER_ID})
endif()
