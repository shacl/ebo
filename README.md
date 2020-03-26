shacl::ebo
==================

## Introduction ##

> I made this letter longer only because I have not had the leisure to make it shorter.

When working with higher level functions in C++, object composition
can be many levels deep. In some cases, the function objects
may have no state, and are referred to as empty classes. Captureless lambda
objects are a example of this circumstance common in practice. Composition of
instances of these classes as member variables incur memory overhead, despite
the fact that these objects store no data.

## Why? ##

The memory footprint of an instance of an empty classes is not permitted to be
less than one byte, prior to C++20. This restriction is a consequence of the
language's lineage from C.

The C standard mandates that a conforming implementation may not introduce
padding between consecutive elements of an array. If an object were allowed
to occupy zero bytes in memory, consecutive elements of an array of an empty
type would reside at the same location in memory. This possibility is
problematic given the iteration conventions in the language, which assume
the addresses to the beginning and (exclusive) end of an array are distinct.

## How does this affect me? ##

The introduction of a byte of memory may seem inconsequential. However, in the
context of object composition, when considered with the memory footprint
introduced by alignment requirements (which, as an aside, is also a consequence
of the aforementioned C mandate), the effect can be substantial.

Consider the following example:

```c++
#include <iostream>
#include <cstdint>

struct A {};
struct B { std::int64_t data; };
struct C {};

struct Composite {
  A a;
  B b;
  C c;
};

int main(){
  std::cout << "A size: " << sizeof(A) << '\n'
            << "B size: " << sizeof(B) << '\n'
            << "C size: " << sizeof(C) << '\n' << '\n'
            << "Composite size: " << sizeof(Composite) << '\n';
}
```

This program has the following output:

```
A size: 1
B size: 8
C size: 1

Composite size: 24
```

Ellision of this memory footprint is available by way of the
'empty base class optimization' or EBO, which is guaranteed as of
C++11. This optimization occurs when a class inherits from a base
class with no member variables. Rewriting the previous example,
we can see that, by leveraging EBO, the overhead of the empty classes
`A` and `C` are eliminated entirely.

```c++
#include <iostream>
#include <cstdint>

struct A {};
struct B { std::int64_t data; };
struct C {};

struct Composite : A, C {
  B b;
};

int main(){
  std::cout << "A size: " << sizeof(A) << '\n'
            << "B size: " << sizeof(B) << '\n'
            << "C size: " << sizeof(C) << '\n' << '\n'
            << "Composite size: " << sizeof(Composite) << '\n';
}
```

This program has the following output:

```
A size: 1
B size: 8
C size: 1

Composite size: 8
```

Given an arbitrary object of type `T`, composition via EBO should be
preferred given `T` is a

+ a non-final class
+ with no member variables

## How does the shacl::ebo library help?

This decision making is somewhat difficult in the case of multiple
composition in a generic context. Given `N` composition parameters,
there are `2^N` possible instantiations based on whether each parameter
is composed via EBO or as a member variable. This quickly becomes either
intractible to write or (for those stubborn enough to brute force out the
exponential number of instantiations) very difficult to maintain. The
`shacl::ebo::Type` class alias encapsulates this decision-making for
generic contexts. Consider the following example.

```c++
#include "shacl/ebo.hpp"

#include <iostream>
#include <cstdint>

template<typename F0, typename F1, typename M>
class Combine : shacl::ebo::Type<F0, F1, M> {
public:
  using shacl::ebo::Type<F0, F1, M>::Type;

  template<typename Arg>
  auto operator()(Arg&& arg) const {
    decltype(auto) f0 = this->get(shacl::ebo::index<0>);
    decltype(auto) f1 = this->get(shacl::ebo::index<1>);
    decltype(auto) m  = this->get(shacl::ebo::index<2>);
    return m(f0(arg), f1(arg));
  }
};

template<typename F0, typename F1, typename M>
auto combine(F0 f0, F1 f1, M m){
  return Combine<F0, F1, M>{f0, f1, m};
}

int main(){
  {
    // Combine three empty classes

    auto eee = combine([](auto x){ return x + 1; },
                       [](auto x){ return 2 * x; },
                       [](auto x, auto y){ return y - x; });

    std::cout << "eee size: " << sizeof(eee) << '\n';
    std::cout << "eee is empty? : "
              << (std::is_empty<decltype(eee)>::value ? "yes" : "no")
              << "\n\n";
  }{
    // Combine two empty classes and a non-empty class

    std::int64_t i = 10;
    auto nee = combine([i](auto x){ return x + i; },
                       [](auto x){ return 2 * x; },
                       [](auto x, auto y){ return y - x; });

    std::cout << "nee size: " << sizeof(nee) << '\n';
    std::cout << "nee is empty? : "
              << (std::is_empty<decltype(nee)>::value ? "yes" : "no")
              << "\n\n";
  }
}
```

This program has the following output:

```
eee size: 1
eee is empty? : yes

nee size: 8
nee is empty? : no
```

## License ##

See [license file.](./LICENSE)
