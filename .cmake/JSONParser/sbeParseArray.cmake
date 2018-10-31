macro(_sbeParseArray prefix)
  math(EXPR json_ArrayNestingLevel "${json_ArrayNestingLevel} + 1")
  set(json_${json_ArrayNestingLevel}_arrayIndex 0)

  set(${prefix} "")
  list(APPEND ${json_AllVariables} ${prefix})

  while(${json_index} LESS ${json_jsonLen})
    string(SUBSTRING "${json_string}" ${json_index} 1 json_char)

    if("\"" STREQUAL "${json_char}")
      # simple value
      list(APPEND ${prefix} ${json_${json_ArrayNestingLevel}_arrayIndex})
      _sbeParseValue(${prefix}.${json_${json_ArrayNestingLevel}_arrayIndex})
    elseif("{" STREQUAL "${json_char}")
      # object
      _sbeMoveToNextNonEmptyCharacter()
      list(APPEND ${prefix} ${json_${json_ArrayNestingLevel}_arrayIndex})
      _sbeParseObject(${prefix}.${json_${json_ArrayNestingLevel}_arrayIndex})
    else()
      list(APPEND ${prefix} ${json_${json_ArrayNestingLevel}_arrayIndex})
      _sbeParseReservedWord(${prefix}.${json_${json_ArrayNestingLevel}_arrayIndex})
    endif()
    
    if(NOT ${json_index} LESS ${json_jsonLen})
      break()
    endif()
    
    string(SUBSTRING "${json_string}" ${json_index} 1 json_char)
    
    if("]" STREQUAL "${json_char}")
      _sbeMoveToNextNonEmptyCharacter()
      break()
    elseif("," STREQUAL "${json_char}")
      math(EXPR json_${json_ArrayNestingLevel}_arrayIndex "${json_${json_ArrayNestingLevel}_arrayIndex} + 1")            
    endif()

    _sbeMoveToNextNonEmptyCharacter()
  endwhile()    
  
  if(${json_MaxArrayNestingLevel} LESS ${json_ArrayNestingLevel})
    set(json_MaxArrayNestingLevel ${json_ArrayNestingLevel})
  endif()
  math(EXPR json_ArrayNestingLevel "${json_ArrayNestingLevel} - 1")
endmacro()
