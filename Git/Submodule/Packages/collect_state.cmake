# This macro populates the current_hash and current_branch variables
macro(git_submodule_collect_state name)
  execute_process(
    COMMAND ${GIT_EXECUTABLE} rev-parse HEAD
    WORKING_DIRECTORY "${${name}.submodule.path}"
    RESULT_VARIABLE failure
    OUTPUT_VARIABLE current_hash
    OUTPUT_STRIP_TRAILING_WHITESPACE
    ERROR_VARIABLE error_output)

  if(failure)
    if(NOT EXISTS "${${name}.submodule.path}")
      file(MAKE_DIRECTORY "${${name}.submodule.path}")
    endif()
    message(FATAL_ERROR ${error_output})
  endif()

  set(${name}.submodule.hash "${current_hash}" CACHE STRING
    "${name} git submodule hash")

  mark_as_advanced(${name}.submodule.hash)
  unset(failure)
  unset(error_output)
endmacro()
