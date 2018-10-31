function(git_submodule_list)
  execute_process(
    COMMAND ${GIT_EXECUTABLE} rev-parse --show-toplevel
    WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
    OUTPUT_VARIABLE git_root
    OUTPUT_STRIP_TRAILING_WHITESPACE)
  if(EXISTS "${git_root}/.gitmodules")
    execute_process(
      COMMAND ${GIT_EXECUTABLE} config --file ${git_root}/.gitmodules --get-regexp path
      OUTPUT_VARIABLE path_output
      OUTPUT_STRIP_TRAILING_WHITESPACE)

    string(REPLACE "\n" ";" path_output "${path_output}")

    foreach(arg IN LISTS path_output)
      string(REPLACE " " ";" arg "${arg}")
      list(GET arg 0 first)
      list(GET arg -1 second)
      set(path "${git_root}/${second}")

      if (EXISTS ${path})
        get_filename_component(name ${path} NAME)
        list(APPEND submodules ${name})

        CMAKE_DEPENDENT_OPTION(
          ${name}.submodule
          "Use dependency submodule rather than system installations" ON
          "git.submodule.packages" OFF)

        mark_as_advanced(${name}.submodule)

        if(git.submodule.packages AND ${${name}.submodule})
          set(${name}.submodule.path
            "${path}"
            CACHE PATH "Absolute path to ${name} git submodule")

          string(REPLACE ".path" ".branch" query "${first}")
          execute_process(
            COMMAND ${GIT_EXECUTABLE} config --file .gitmodules --get ${query}
            WORKING_DIRECTORY "${git_root}"
            OUTPUT_VARIABLE branch
            RESULT_VARIABLE failure
            OUTPUT_STRIP_TRAILING_WHITESPACE)

          if(NOT failure)
            set(${name}.submodule.branch "${branch}"
              CACHE STRING "Branch tracked by ${name} git submodule")
            mark_as_advanced(${name}.submodule.branch)
          endif()
        endif()
      endif()
    endforeach()
  endif()

  set(${PROJECT_NAME}.submodules
    ${submodules} CACHE INTERNAL
    "A CMake list of git submodules for ${PROJECT_NAME}")
endfunction()
