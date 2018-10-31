backup(target_sources)

function(target_sources target tag linkage)
  if(NOT ${tag} STREQUAL "GENERATED")
    previous_target_sources(${ARGV})
    return()
  endif()

  get_target_property(library_type ${target} TYPE)

  stripped(${target})
  foreach(entry ${ARGN})
    if(entry STREQUAL "PUBLIC"
        OR entry STREQUAL "PRIVATE"
        OR entry STREQUAL "INTERFACE")

      if(library_type STREQUAL "INTERFACE_LIBRARY"
          AND NOT entry STREQUAL "INTERFACE")
        message(FATAL_ERROR
          "Only interface sources may be added to interface targets")
      endif()

      set(linkage ${entry})
    else()
      string(REGEX MATCH "[$]<.*>$" generator_expression ${entry})
      if("${generator_expression}")
        message(FATAL_ERROR
          "Generator expressions are unavailable in GENERATED target_sources invocations")
      endif()

      unset(generator_expression)
      previous_target_sources(${stripped_target_name}.generated_sources.${linkage} INTERFACE "${entry}")

      get_filename_component(directory ${entry} DIRECTORY)
      get_filename_component(file ${entry} NAME)
      string(REPLACE "." "_" file "${file}")

      file(RELATIVE_PATH relative_path "${PROJECT_BINARY_DIR}" "${directory}")
      string(SHA256 path_hash "${relative_path}")

      foreach(index RANGE 7 63)
        string(SUBSTRING ${path_hash} 0 ${index} potential_hash)
        set(custom_target ${stripped_target_name}.${potential_hash}.${file})
        if(NOT TARGET ${custom_target})
          break()
        endif()
      endforeach()

      add_custom_target(${custom_target} DEPENDS ${entry})
      set_target_properties(
        ${custom_target} PROPERTIES FOLDER generated)

      add_dependencies(
        ${stripped_target_name}.generated_sources.${linkage}
        ${custom_target})
    endif()
  endforeach()
endfunction()
