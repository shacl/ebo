cmake_minimum_required(VERSION 3.12.1)
include_guard(GLOBAL)
if( SLURM_SRUN_COMMAND ) 
   set( BATCH_COMMAND ${SLURM_SRUN_COMMAND} CACHE STRING "Batch run command" )
   set( BATCH_OPTIONS --exclusive -m cyclic --cpu_bind=none CACHE STRING "Batch run command options" )
   set( BATCH_NUMPROC_FLAG -n  CACHE STRING "Flag for number of MPI processes" )
   set( BATCH_NTHREAD_FLAG -c  CACHE STRING "Flag for number of threads" ) 
endif()

install(FILES
  ${CMAKE_CURRENT_LIST_DIR}/Slurm.cmake
  DESTINATION share/cmake/shacl/.cmake/Batch)
