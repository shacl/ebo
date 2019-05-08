cmake_minimum_required(VERSION 3.12.1)
string(CONCAT generator
  "$<$<BOOL:$<TARGET_PROPERTY:WARN_ERROR>>:-Werror>;"
  "$<$<BOOL:$<TARGET_PROPERTY:WARN_ALL>>:"
    "-Wall;"
    "-Wextra;"
    "-Wpedantic;"
    "-Wsuggest-override;"
    "$<$<VERSION_GREATER:$<C_COMPILER_VERSION>,7.0>:-Wduplicated-branches>;"
    "$<$<VERSION_GREATER:$<C_COMPILER_VERSION>,6.0>:-Wduplicated-cond>>;"
  "$<$<BOOL:$<TARGET_PROPERTY:GNU_ENABLED_WARNINGS>>:"
    "-W$<JOIN:$<TARGET_PROPERTY:GNU_ENABLED_WARNINGS>,;-W>>;"
  "$<$<BOOL:$<TARGET_PROPERTY:GNU_DISABLED_WARNINGS>>:"
    "-Wno-$<JOIN:$<TARGET_PROPERTY:GNU_DISABLED_WARNINGS>,;-Wno->>;")

target_compile_options(shacl::cmake::Warnings_CXX INTERFACE
  $<$<CXX_COMPILER_ID:GNU>:${generator}>)
