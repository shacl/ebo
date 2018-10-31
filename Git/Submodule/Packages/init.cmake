function(git_submodule_init name)
  if(NOT EXISTS "${${name}.submodule.path}/.git" )
    execute_process(
      COMMAND ${GIT_EXECUTABLE} submodule update --init -- "${${name}.submodule.path}"
      WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}"
      OUTPUT_QUIET
      RESULT_VARIABLE failure
      ERROR_VARIABLE error_output)

    if(failure)
      if(NOT EXISTS "${${name}.submodule.path}")
        file(MAKE_DIRECTORY "${${name}.submodule.path}")
      endif()
      message(FATAL_ERROR "${error_output}")
    endif()
  endif()

  git_submodule_collect_state(${name})
endfunction()
