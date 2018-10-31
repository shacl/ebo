## the SHACL Git Submodule packages module

The intent of this CMake module extends the functionality of CMake's
`find_package` function to allow git submodules to act as a back-end. The
implementation of this functionality relies on an, admittedly, obscure CMake
feature. Please see documentation/function-extension.md for more information.

In the case that a git submodule does not exist, the `find_package` function
falls back to the traditional behavior.
