cmake_minimum_required(VERSION 3.12.1)
include_guard(GLOBAL)
include(CMakeParseArguments)

function(target_Fortran_module_directory target linkage)
  set(oneValueArgs BUILD_INTERFACE INSTALL_INTERFACE)
  cmake_parse_arguments(target_Fortran_module_directory "" "${oneValueArgs}" "" ${ARGN})

  if(NOT target_Fortran_module_directory_BUILD_INTERFACE)
    message(FATAL_ERROR "target_Fortran_module_directory on target \"${target}\" missing BUILD_INTERFACE argument")
  endif()

  file(MAKE_DIRECTORY "${target_Fortran_module_directory_BUILD_INTERFACE}")

  set(multiconfig_suffix "")
  if( CMAKE_CONFIGURATION_TYPES )
    set(multiconfig_suffix "/$<CONFIG>")
  endif()

  target_include_directories("${target}" "${linkage}" 
    $<BUILD_INTERFACE:${target_Fortran_module_directory_BUILD_INTERFACE}${multiconfig_suffix}>
  )
  set_target_properties("${target}" PROPERTIES
    Fortran_MODULE_DIRECTORY ${target_Fortran_module_directory_BUILD_INTERFACE}
  )

  if( target_Fortran_module_directory_INSTALL_INTERFACE )
    target_include_directories("${target}" "${linkage}"
      $<INSTALL_INTERFACE:${target_Fortran_module_directory_INSTALL_INTERFACE}>
    )

    install(DIRECTORY ${target_Fortran_module_directory_BUILD_INTERFACE}${multiconfig_suffix}/
      DESTINATION ${target_Fortran_module_directory_INSTALL_INTERFACE}
    )
  endif()
endfunction()

install(FILES 
  ${CMAKE_CURRENT_LIST_DIR}/ModuleDirectory.cmake
  DESTINATION share/cmake/shacl/.cmake/Fortran)
