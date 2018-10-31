#include <cassert>
#include <fstream>
#include <iostream>
#include <string>

int main(int argc, char* argv[]){
  std::ifstream source(argv[1]);
  std::string sink;
  for (int i = 2; i < argc; ++i){
    std::getline(source, sink);
    std::cout << sink << ' ' << argv[i] << std::endl;
    assert(sink == argv[i]);
  }
}
