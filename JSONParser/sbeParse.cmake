macro(_sbeParse prefix)

  while(${json_index} LESS ${json_jsonLen})
    string(SUBSTRING "${json_string}" ${json_index} 1 json_char)
    
    if("\"" STREQUAL "${json_char}")    
      _sbeParseNameValue(${prefix})
    elseif("{" STREQUAL "${json_char}")
      _sbeMoveToNextNonEmptyCharacter()
      _sbeParseObject(${prefix})
    elseif("[" STREQUAL "${json_char}")
      _sbeMoveToNextNonEmptyCharacter()
      _sbeParseArray(${prefix})
    endif()

    if(${json_index} LESS ${json_jsonLen})
      string(SUBSTRING "${json_string}" ${json_index} 1 json_char)
    else()
      break()
    endif()

    if ("}" STREQUAL "${json_char}" OR "]" STREQUAL "${json_char}")
      break()
    endif()
    
    _sbeMoveToNextNonEmptyCharacter()
  endwhile()    
endmacro()
 
