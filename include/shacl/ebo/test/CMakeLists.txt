add_executable(shacl.ebo.test ebo.test.cpp)
target_link_libraries(shacl.ebo.test PRIVATE shacl::ebo::testing)
add_test(NAME shacl.ebo.test COMMAND shacl.ebo.test)
