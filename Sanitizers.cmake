include(Backports/IncludeGuard)
include_guard(GLOBAL)

define_property(TARGET PROPERTY asan
  BRIEF_DOCS "Enable address sanitizer"
  FULL_DOCS "AddressSanitizer (aka ASan) is a tool that detects memory error")
define_property(TARGET PROPERTY msan
  BRIEF_DOCS "Enable memory sanitizer"
  FULL_DOCS "MemorySanitizer (aka MSan) is a tool that detects reads from uninitialized memory")
define_property(TARGET PROPERTY tsan
  BRIEF_DOCS "Enable thread sanitizer"
  FULL_DOCS "ThreadSanitizer (aka TSan) is a tool that detects data races.")
define_property(TARGET PROPERTY ubsan
  BRIEF_DOCS "Enable undefined behavior sanitizer"
  FULL_DOCS "UndefinedBehaviorSanitizer (aka UBSan) is a tool that detects undefined behavior")

option(asan.default
  "Default address sanitizer behavior (ON/OFF)" OFF)
mark_as_advanced(asan.default)

option(msan.default
  "Default memory sanitizer behavior (ON/OFF)" OFF)
mark_as_advanced(msan.default)

option(tsan.default
  "Default thread sanitizer behavior (ON/OFF)" OFF)
mark_as_advanced(tsan.default)

option(ubsan.default
  "Default undefined behavior sanitizer behavior (ON/OFF)" OFF)
mark_as_advanced(ubsan.default)

add_library(sanitizers INTERFACE)
add_library(shacl::sanitizers ALIAS sanitizers)

set(asan address)
set(msan memory)
set(tsan thread)
set(ubsan undefined)
set(compilation_generator)
set(linking_generator)

foreach(sanitizer IN ITEMS asan msan tsan ubsan)
  string(CONCAT compilation_generator
    "${compilation_generator}"
    "$<$<OR:$<BOOL:$<TARGET_PROPERTY:${sanitizer}>>,"
           "$<BOOL:${${sanitizer}.default}>"
     ">:-fsanitize=${${sanitizer}};-fno-omit-frame-pointer;-fno-sanitize-recover=all>;")

  string(CONCAT linking_generator
    "${linking_generator}"
    "$<$<OR:$<BOOL:$<TARGET_PROPERTY:${sanitizer}>>,"
           "$<BOOL:${${sanitizer}.default}>"
      ">:-fsanitize=${${sanitizer}}>;")
endforeach()

target_compile_options(sanitizers INTERFACE ${compilation_generator})
target_link_libraries(sanitizers INTERFACE ${linking_generator})

add_library(sanitizers_C INTERFACE)
add_library(sanitizers_CXX INTERFACE)
add_library(sanitizers_Fortran INTERFACE)
add_library(shacl::sanitizers_C ALIAS sanitizers_C)
add_library(shacl::sanitizers_CXX ALIAS sanitizers_CXX)
add_library(shacl::sanitizers_Fortran ALIAS sanitizers_Fortran)

get_property(languages GLOBAL PROPERTY ENABLED_LANGUAGES)
foreach(language IN ITEMS C CXX Fortran)
  set(vendor_discrimination)
  if(language IN_LIST languages)
    string(CONCAT vendor_discrimination
      "$<$<OR:$<STREQUAL:GNU,${CMAKE_${language}_COMPILER_ID}>,"
      "$<STREQUAL:Clang,${CMAKE_${language}_COMPILER_ID}>,"
      "$<STREQUAL:AppleClang,${CMAKE_${language}_COMPILER_ID}>>"
      ":shacl::sanitizers>")
    target_link_libraries(sanitizers_${language} INTERFACE ${vendor_discrimination})
  endif()
endforeach()
