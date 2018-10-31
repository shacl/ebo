get_property(
  GeneratedSources.configure_directory.cmake
  GLOBAL PROPERTY GeneratedSources.configure_directory.cmake SET)

if(NOT GeneratedSources.configure_directory.cmake)
  function(configure_directory)
    get_property(directory_configured 
      DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
      PROPERTY directory_targets SET)

    if(directory_configured)
      return()
    endif()

    set_property(
      DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
      PROPERTY directory_targets)
  endfunction()

  include(GeneratedSources/generated_sources_trap)
endif()
