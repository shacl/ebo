## the SHACL Generated Sources module

The intent of this CMake module is improve support for the use of source files
generated during the build step in library and executable targets. While CMake
provides out-of-the-box support for this task, the mechanics are obscure and
difficult to use correctly.

In this module, several CMake intrinsics are extended to simplify this process.

  + `add_library`
  + `add_executable`
  + `target_sources`

The implementation of this functionality relies on an, admittedly, obscure CMake
feature. Please see `documentation/function-extension.md` for more information.

The `add_library` and `add_executable` functions can be used without
consideration of the extension, i.e.,

```
 add_library(<target name> [STATIC | SHARED | MODULE]
             [EXCLUDE_FROM_ALL]
             source1 [source2 ...])

 add_executable(<target name> [WIN32] [MACOSX_BUNDLE]
                [EXCLUDE_FROM_ALL]
                source1 [source2 ...])
```

In addition to the traditional target, these augmented function will
silently generate 3 interface library targets:

 + `<target name>.generated_sources.PUBLIC`
 + `<target name>.generated_sources.PRIVATE`
 + `<target name>.generated_sources.INTERFACE`

Unfortunately these (internal-purpose) targets appear as targets from IDEs
such as XCode or Visual Studios. Until the FOLDER target property is
whitelisted for INTERFACE targets, there doesn't appear to be a work around
for this inconvenience.

These targets interact with an extension to the `target_sources` intrinsic
function. In addition to the usual signature, this module provides an additional
signature.

```
 target_sources(
   <target name> GENERATED
   <INTERFACE|PUBLIC|PRIVATE> [items1...]
   [<INTERFACE|PUBLIC|PRIVATE> [items2...] ...])
```

Note the addition of the `GENERATED` keyword with respect to the traditional
`target_sources`. Adding generated sources using this signature will remove
any requirement that consuming targets be declared within the same
CMakeLists.txt file, that custom targets be declared for dependency
management or that sources be explicitly declared `GENERATED` in the
consuming targets CMakeLists.txt.

Unfortunately, due to limitations in the `add_custom_target` function used in
the implementation (and unlike the traditional `target_sources`), generator
expressions are not supported.

These sources are only added to their respective target in the build interface.
If these sources need be available in the install interface, a second
(traditional) call to target sources is necessary, e.g.,

```
target_sources(myTarget
  GENERATED PUBLIC ${CMAKE_CURRENT_BINARY_DIR}/example.hpp)

target_sources(myTarget
  PUBLIC $<INSTALL_INTERFACE:include/myTarget/example.hpp>)
```
