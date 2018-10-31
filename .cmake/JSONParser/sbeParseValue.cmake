macro(_sbeParseValue prefix)
  cmake_policy(SET CMP0054 NEW) # turn off implicit expansions in if statement
  
  set(json_value "")
  set(json_inValue no)
  
  while(${json_index} LESS ${json_jsonLen})
    # fast path for copying strings
    if (json_inValue)
      # attempt to gobble up to 128 bytes of string
      string(SUBSTRING "${json_string}" ${json_index} 128 try_gobble)
      # consume a piece of string we can just straight copy before encountering \ or "
      string(REGEX MATCH "^[^\"\\\\]+" simple_copy "${try_gobble}")
      string(CONCAT json_value "${json_value}" "${simple_copy}")
      string(LENGTH "${simple_copy}" copy_length)
      math(EXPR json_index "${json_index} + ${copy_length}")
    endif()

    string(SUBSTRING "${json_string}" ${json_index} 1 json_char)

    # check if json_value ends, it is ended by "
    if("\"" STREQUAL "${json_char}" AND json_inValue)
      set(json_inValue no)
      set(${prefix} ${json_value})
      list(APPEND ${json_AllVariables} ${prefix})
      _sbeMoveToNextNonEmptyCharacter()
      break()
    endif()
    
    if(json_inValue)
      # if " is escaped consume
      if("\\" STREQUAL "${json_char}")
        math(EXPR json_index "${json_index} + 1")
        if(NOT ${json_index} LESS ${json_jsonLen})
          break()
        endif()                
        string(SUBSTRING "${json_string}" ${json_index} 1 json_char)
        if(NOT "\"" STREQUAL "${json_char}")
          # if it is not " then copy also escape character
          set(json_char "\\${json_char}")
        endif()
      endif()      
      
      _sbeAddEscapedCharacter("${json_char}")
    endif()
    
    # check if value starts
    if("\"" STREQUAL "${json_char}" AND NOT json_inValue)
      set(json_inValue yes)
    endif()
    
    math(EXPR json_index "${json_index} + 1")
  endwhile()
endmacro()
