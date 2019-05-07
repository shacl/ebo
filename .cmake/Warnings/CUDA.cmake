cmake_minimum_required(VERSION 3.12.1)

check_language(CUDA)
if(DEFINED CMAKE_CUDA_COMPILER)
  add_library(shacl::cmake::Warnings_CUDA INTERFACE IMPORTED GLOBAL)
  include(Warnings/CUDA/NVIDIA)
endif()
