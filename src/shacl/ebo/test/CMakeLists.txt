add_executable(ebo.test ebo.test.cpp)
target_link_libraries(ebo.test PRIVATE shacl::ebo::testing)
add_test(NAME ebo.test COMMAND ebo.test)
