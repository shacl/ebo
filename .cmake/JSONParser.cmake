cmake_minimum_required(VERSION 3.5.2)

include(${CMAKE_CURRENT_LIST_DIR}/Backports/IncludeGuard.cmake)

include_guard(GLOBAL)

include(${CMAKE_CURRENT_LIST_DIR}/JSONParser/sbeParseJson.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/JSONParser/sbeClearJson.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/JSONParser/sbePrintJson.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/JSONParser/sbeParse.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/JSONParser/sbeParseNameValue.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/JSONParser/sbeParseReservedWord.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/JSONParser/sbeParseValue.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/JSONParser/sbeAddEscapedCharacter.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/JSONParser/sbeParseObject.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/JSONParser/sbeParseArray.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/JSONParser/sbeMoveToNextNonEmptyCharacter.cmake)
