macro(_sbeParseNameValue prefix)
  set(json_name "")
  set(json_inName no)

  while(${json_index} LESS ${json_jsonLen})
    string(SUBSTRING "${json_string}" ${json_index} 1 json_char)
    
    # check if name ends
    if("\"" STREQUAL "${json_char}" AND json_inName)
      set(json_inName no)
      _sbeMoveToNextNonEmptyCharacter()
      if(NOT ${json_index} LESS ${json_jsonLen})
        break()
      endif()                
      string(SUBSTRING "${json_string}" ${json_index} 1 json_char)

      if(${object_depth})
        list(APPEND ${prefix} ${json_name} )
      endif()

      set(json_newPrefix ${prefix}.${json_name})
      set(json_name "")
      
      if(":" STREQUAL "${json_char}")
        _sbeMoveToNextNonEmptyCharacter()
        if(NOT ${json_index} LESS ${json_jsonLen})
          break()
        endif()                
        string(SUBSTRING "${json_string}" ${json_index} 1 json_char)

        if("\"" STREQUAL "${json_char}")    
          _sbeParseValue(${json_newPrefix})
          break()
        elseif("{" STREQUAL "${json_char}")
          _sbeMoveToNextNonEmptyCharacter()
          _sbeParseObject(${json_newPrefix})
          break()
        elseif("[" STREQUAL "${json_char}")
          _sbeMoveToNextNonEmptyCharacter()
          _sbeParseArray(${json_newPrefix})
          break()
        else()
          # reserved word starts
          _sbeParseReservedWord(${json_newPrefix})
          break()
        endif()
      else()
        # name without value
        list(APPEND ${json_AllVariables} ${json_newPrefix})
        set(${json_newPrefix} "")
        break()            
      endif()           
    endif()

    if(json_inName)
      # remove escapes
      if("\\" STREQUAL "${json_char}")
        math(EXPR json_index "${json_index} + 1")
        if(NOT ${json_index} LESS ${json_jsonLen})
          break()
        endif()                
        string(SUBSTRING "${json_string}" ${json_index} 1 json_char)
      endif()
      
      set(json_name "${json_name}${json_char}")
    endif()
    
    # check if name starts
    if("\"" STREQUAL "${json_char}" AND NOT json_inName)
      set(json_inName yes)
    endif()
    
    _sbeMoveToNextNonEmptyCharacter()
  endwhile()    
endmacro()

