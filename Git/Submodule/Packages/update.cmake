function(git_submodule_update name)
  if(${name}.submodule.branch)
    if(git.submodule.update)
      execute_process(
        COMMAND ${GIT_EXECUTABLE} submodule update --remote -- ${${name}.submodule.path}
        WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
        RESULT_VARIABLE failure
        ERROR_VARIABLE error_output)

      if(failure)
        if(NOT EXISTS "${${name}.submodule.path}")
          file(MAKE_DIRECTORY "${${name}.submodule.path}")
        endif()
        message(FATAL_ERROR ${error_output})
      endif()
    endif()
  endif()
endfunction()
