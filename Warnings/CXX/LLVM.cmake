string(CONCAT generator
  "$<$<BOOL:$<TARGET_PROPERTY:WARN_ERROR>>:-Werror>;"
  "$<$<BOOL:$<TARGET_PROPERTY:WARN_ALL>>:"
    "-Wall;"
    "-Wextra;"
    "-Wpedantic;"
    "-Wassign-enum;"
    "-Wbad-function-cast;"
    "-Wkeyword-macro;"
    "-Wnonportable-system-include-path;"
    "-Wsometimes-uninitialized;"
    "-Wold-style-cast;"
    "-Wnon-virtual-dtor;"
    "-Wrange-loop-analysis;"
    "-Wredundant-move>;"
  "$<$<BOOL:$<TARGET_PROPERTY:LLVM_ENABLED_WARNINGS>>:"
    "-W$<JOIN:$<TARGET_PROPERTY:LLVM_ENABLED_WARNINGS>,;-W>>;"
  "$<$<BOOL:$<TARGET_PROPERTY:LLVM_DISABLED_WARNINGS>>:"
    "-Wno-$<JOIN:$<TARGET_PROPERTY:LLVM_DISABLED_WARNINGS>,;-Wno->>;")

target_compile_options(Warnings_CXX INTERFACE
  $<$<OR:$<CXX_COMPILER_ID:AppleClang>,$<CXX_COMPILER_ID:Clang>>:${generator}>)
