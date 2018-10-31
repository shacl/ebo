# Here we're using the existance of global properties to act as something
# analoguous to C/C++ header guards to ensure the contents of this file are not
# redundantly defined.

get_property(
  GeneratedSources.generated_sources_trap.cmake
  GLOBAL PROPERTY GeneratedSources.generated_sources_trap.cmake SET)

if(NOT GeneratedSources.generated_sources_trap.cmake)
  function(append_generated_files variable access)
    if(${access} STREQUAL UNKNOWN_READ_ACCESS 
        OR ${access} STREQUAL READ_ACCESS)

      get_property(directory_targets
        DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
        PROPERTY directory_targets)

      if(directory_targets)
        foreach(directory_target IN LISTS directory_targets)
          stripped(${directory_target})

          if(NOT TARGET ${stripped_target_name}.generated_sources.PUBLIC)
            return()
          endif()

          foreach(linkage PUBLIC PRIVATE INTERFACE)
            get_target_property(sources
              ${stripped_target_name}.generated_sources.${linkage}
              INTERFACE_SOURCES)
            
            if(NOT sources STREQUAL "sources-NOTFOUND")
              foreach(source IN LISTS sources)
                set_source_files_properties(${source} PROPERTIES GENERATED TRUE)
              endforeach()
            endif()
          endforeach()
        endforeach()
      endif()
    endif()
  endfunction()

  variable_watch(CMAKE_BACKWARDS_COMPATIBILITY append_generated_files)
    
  macro(generated_sources_trap target)
    get_property(directory_targets 
      DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
      PROPERTY directory_targets)

    set_property(
      DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
      PROPERTY directory_targets ${directory_targets} ${target})

    unset(directory_targets)
  endmacro()

  set_property(GLOBAL PROPERTY GeneratedSources.generated_sources_trap.cmake
    "This is a header guard")
endif()
