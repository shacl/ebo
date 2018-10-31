backup(add_executable)

function(add_executable target)
  previous_add_executable(${ARGV} "")

  stripped(${target})
  previous_add_library(${stripped_target_name}.generated_sources.PUBLIC INTERFACE)
  target_link_libraries(${target} PUBLIC
    $<BUILD_INTERFACE:${stripped_target_name}.generated_sources.PUBLIC>)

  previous_add_library(${stripped_target_name}.generated_sources.PRIVATE INTERFACE)
  target_link_libraries(${target} PRIVATE
    $<BUILD_INTERFACE:${stripped_target_name}.generated_sources.PRIVATE>)

  previous_add_library(${stripped_target_name}.generated_sources.INTERFACE INTERFACE)
  target_link_libraries(${target} INTERFACE
    $<BUILD_INTERFACE:${stripped_target_name}.generated_sources.INTERFACE>)

  export(TARGETS
    ${stripped_target_name}.generated_sources.PUBLIC
    ${stripped_target_name}.generated_sources.PRIVATE
    ${stripped_target_name}.generated_sources.INTERFACE
    NAMESPACE export::
    FILE ${CMAKE_CURRENT_BINARY_DIR}/faux-exports/${stripped_target_name}.cmake)
endfunction()
