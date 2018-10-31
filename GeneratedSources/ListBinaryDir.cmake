function(update_LIST_BINARY_DIR variable access)
  if(${access} STREQUAL UNKNOWN_READ_ACCESS 
      OR ${access} STREQUAL READ_ACCESS)

    file(RELATIVE_PATH 
      relative_path 
      "${CMAKE_SOURCE_DIR}" 
      "${CMAKE_CURRENT_LIST_DIR}")
    
    if(relative_path)
      set(LIST_BINARY_DIR "${CMAKE_BINARY_DIR}/${relative_path}" PARENT_SCOPE)
    else()
      set(LIST_BINARY_DIR "${CMAKE_BINARY_DIR}" PARENT_SCOPE)
    endif()

  endif()
endfunction()

variable_watch(LIST_BINARY_DIR update_LIST_BINARY_DIR)
