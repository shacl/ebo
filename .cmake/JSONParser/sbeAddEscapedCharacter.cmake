macro(_sbeAddEscapedCharacter char)
  string(CONCAT json_value "${json_value}" "${char}")
endmacro()
