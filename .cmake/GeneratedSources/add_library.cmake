backup(add_library)

function(add_library)
  previous_add_library("${ARGN}")

  set(target ${ARGV0})
  set(keyword ${ARGV1})
  get_target_property(is_alias ${target} ALIASED_TARGET)
  get_target_property(is_imported ${target} IMPORTED)
  get_target_property(library_type ${target} TYPE)

  if(is_alias OR is_imported OR target MATCHES "generated_sources")
    return()
  endif()

  set(libraries INTERFACE_LIBRARY STATIC_LIBRARY SHARED_LIBRARY)
  if(NOT library_type IN_LIST libraries)
    return()
  endif()

  stripped(${target})

  previous_add_library(${stripped_target_name}.generated_sources.INTERFACE INTERFACE)
  target_link_libraries(${target} INTERFACE
    $<BUILD_INTERFACE:${stripped_target_name}.generated_sources.INTERFACE>)

  if(NOT library_type STREQUAL "INTERFACE_LIBRARY")
    previous_add_library(${stripped_target_name}.generated_sources.PUBLIC INTERFACE)
    target_link_libraries(${target} PUBLIC
      $<BUILD_INTERFACE:${stripped_target_name}.generated_sources.PUBLIC>)

    previous_add_library(${stripped_target_name}.generated_sources.PRIVATE INTERFACE)
    target_link_libraries(${target} PRIVATE
      $<BUILD_INTERFACE:${stripped_target_name}.generated_sources.PRIVATE>)

    export(TARGETS
      ${stripped_target_name}.generated_sources.PUBLIC
      ${stripped_target_name}.generated_sources.PRIVATE
      ${stripped_target_name}.generated_sources.INTERFACE
      NAMESPACE export::
      FILE ${CMAKE_CURRENT_BINARY_DIR}/faux-exports/${stripped_target_name}.cmake)
  else()
    export(TARGETS ${stripped_target_name}.generated_sources.INTERFACE
      NAMESPACE export::
      FILE ${CMAKE_CURRENT_BINARY_DIR}/faux-exports/${stripped_target_name}.cmake)
  endif()
endfunction()
