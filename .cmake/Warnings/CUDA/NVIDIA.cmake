cmake_minimum_required(VERSION 3.12.1)
string(CONCAT generator
  "-Xcompiler;"
  "$<JOIN:$<GENEX_EVAL:$<TARGET_PROPERTY:Warnings_CXX,INTERFACE_COMPILE_OPTIONS>>,$<COMMA>>"
  "$<$<CXX_COMPILER_ID:GNU>:,-Wno-pedantic>")

target_compile_options(shacl::cmake::Warnings_CUDA INTERFACE
  $<$<STREQUAL:${CMAKE_CUDA_COMPILER_ID},NVIDIA>:${generator}>)
