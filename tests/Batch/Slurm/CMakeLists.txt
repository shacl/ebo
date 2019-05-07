cmake_minimum_required( VERSION 3.10 )
project( test_slurm )

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/../..)
include(Batch)

if(SLURM_SRUN_COMMAND)
  get_filename_component( BATCH_COMMAND ${BATCH_COMMAND} NAME )
  set( prefix_command ${BATCH_COMMAND} ${BATCH_OPTIONS}
    ${BATCH_NUMPROC_FLAG} 2  
    ${BATCH_NTHREAD_FLAG} 4 )	

  file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/test_result "${prefix_command}")

  add_test(
    NAME
      shacl.cmake.slurm_test
    COMMAND
      ${CMAKE_COMMAND} -E compare_files
      "${CMAKE_CURRENT_SOURCE_DIR}/reference"
      "${CMAKE_CURRENT_BINARY_DIR}/test_result"
      )
endif()
