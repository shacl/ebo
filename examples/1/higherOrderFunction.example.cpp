#include <iostream>
#include "shacl/ebo.hpp"

template<typename F0, typename F1, typename M>
class Combine : shacl::ebo::Type<F0, F1, M> {
public:
  using shacl::ebo::Type<F0, F1, M>::Type;

  template<typename Arg,
           typename R0 = shacl::trait::InvokeResult_t<F0, Arg>,
           typename R1 = shacl::trait::InvokeResult_t<F0, Arg>,
           typename Result = shacl::trait::InvokeResult_t<M, R0, R1>>
  auto operator()(Arg&& arg) const {
    decltype(auto) f0 = this->get(shacl::ebo::index<0>);
    decltype(auto) f1 = this->get(shacl::ebo::index<1>);
    decltype(auto) m = this->get(shacl::ebo::index<2>);
    return m(f0(arg), f1(arg));
  }
};

template<typename F0, typename F1, typename M>
auto combine(F0 f0, F1 f1, M m){
  return Combine<F0, F1, M>{f0, f1, m};
}

int main(){
  auto cf = combine([](auto x){ return x + 1; },
                    [](auto x){ return 2 * x; },
                    [](auto x, auto y){ return y - x; });

  std::cout << "sizeof(cf): "
            << sizeof(cf) << " (should be '1')" << std::endl;
  std::cout << "std::is_empty<decltype(cf)>::value : "
            << (std::is_empty<decltype(cf)>::value ? "yes" : "no")
            << " (should be 'yes')" << std::endl;
  std::cout << "cf(10) : " << cf(10) << " (should be '9')" << std::endl;

}
