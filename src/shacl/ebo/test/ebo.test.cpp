#define CATCH_CONFIG_MAIN

#include "shacl/ebo.hpp"
#include "Catch2/catch.hpp"

struct Empty {};
struct AlsoEmpty {};

struct Final final {};
struct NonEmpty{ int data; };

template<typename T>
struct expose : T {
public:
  template<typename... Us>
  expose(Us&&... us) : T(std::forward<Us>(us)...){}
  using T::get;
};

SCENARIO("Automated Empty base class optimization with mutliple inheritance"){
  GIVEN("a single class"){
    GIVEN("the class is Empty"){
      using Type = expose<shacl::ebo::Type<Empty>>;

      THEN("the resulting type type will be empty"){
        REQUIRE(std::is_empty<Type>::value);
      }

      THEN("the resulting type will be the size of the parameter type"){
        REQUIRE(sizeof(Type) == sizeof(Empty));
      }

      THEN("an instance provides access to an instance of the parameter class"){
        const auto instance = Type{Empty{}};
        using GetResult_t = decltype(instance.get(shacl::ebo::index<0>));
        REQUIRE(std::is_same<GetResult_t, const Empty&>::value);
      }
    }

    GIVEN("the class is NonEmpty"){
      using Type = expose<shacl::ebo::Type<NonEmpty>>;

      THEN("the resulting type type will be not be empty"){
        REQUIRE(not std::is_empty<Type>::value);
      }

      THEN("the resulting type will be the size of the parameter type"){
        REQUIRE(sizeof(Type) == sizeof(NonEmpty));
      }

      THEN("an instance provides access to an instance of the parameter class"){
        const auto instance = Type{NonEmpty{5}};
        using GetResult_t = decltype(instance.get(shacl::ebo::index<0>));
        REQUIRE(std::is_same<GetResult_t, const NonEmpty&>::value);
        REQUIRE(instance.get(shacl::ebo::index<0>).data == 5);
      }
    }

    GIVEN("the class is final"){
      using Type = expose<shacl::ebo::Type<Final>>;

      THEN("the resulting type type will not be empty"){
        REQUIRE(not std::is_empty<Type>::value);
      }

      THEN("the resulting type will be the size of the parameter type"){
        REQUIRE(sizeof(Type) == sizeof(Final));
      }

      THEN("an instance provides access to an instance of the parameter class"){
        const auto instance = Type{Final{}};
        using GetResult_t = decltype(instance.get(shacl::ebo::index<0>));
        REQUIRE(std::is_same<GetResult_t, const Final&>::value);
      }
    }
  }

  GIVEN("multiple classes"){
    GIVEN("all classes NonEmpty"){
      using Type = shacl::ebo::Type<NonEmpty, NonEmpty>;

      THEN("the resulting type type will not be empty"){
        REQUIRE(not std::is_empty<Type>::value);
      }

      THEN("the resulting type will be the size"
           " of the sum of the (non-empty) parameter type sizes"){
        REQUIRE(2 * sizeof(NonEmpty) == sizeof(Type));
      }

      THEN("an instance provides access to an instance of the parameter classes"){
        const auto instance = Type{NonEmpty{5}, NonEmpty{10}};

        WHEN("querying for the first type"){
          using GetResult_t = decltype(instance.get(shacl::ebo::index<0>));
          REQUIRE(std::is_same<GetResult_t, const NonEmpty&>::value);
          REQUIRE(instance.get(shacl::ebo::index<0>).data == 5);
        }

        WHEN("querying for the second type"){
          using GetResult_t = decltype(instance.get(shacl::ebo::index<1>));
          REQUIRE(std::is_same<GetResult_t, const NonEmpty&>::value);
          REQUIRE(instance.get(shacl::ebo::index<1>).data == 10);
        }
      }
    }

    GIVEN("one class empty and one class non-empty"){
      using Type = shacl::ebo::Type<NonEmpty, Empty>;

      THEN("the resulting type type will not be empty"){
        REQUIRE(not std::is_empty<Type>::value);
      }

      THEN("the resulting type will be the size"
           " of the sum of the (non-empty) parameter type sizes"){
        REQUIRE(sizeof(NonEmpty) == sizeof(Type));
      }

      THEN("an instance provides access to an instance of the parameter classes"){
        const auto instance = Type{NonEmpty{5}, Empty{}};

        WHEN("querying for the first type"){
          using GetResult_t = decltype(instance.get(shacl::ebo::index<0>));
          REQUIRE(std::is_same<GetResult_t, const NonEmpty&>::value);
          REQUIRE(instance.get(shacl::ebo::index<0>).data == 5);
        }

        WHEN("querying for the second type"){
          using GetResult_t = decltype(instance.get(shacl::ebo::index<1>));
          REQUIRE(std::is_same<GetResult_t, const Empty&>::value);
        }
      }
    }

    GIVEN("one class empty and one class non-empty"){
      using Type = shacl::ebo::Type<Empty, AlsoEmpty>;

      THEN("the resulting type type will be empty"){
        REQUIRE(std::is_empty<Type>::value);
      }

      THEN("the resulting type will be the size that of an empty type"){
        REQUIRE(sizeof(Empty) == sizeof(Type));
      }

      THEN("an instance provides access to an instance of the parameter classes"){
        const auto instance = Type{Empty{}, AlsoEmpty{}};

        WHEN("querying for the first type"){
          using GetResult_t = decltype(instance.get(shacl::ebo::index<0>));
          REQUIRE(std::is_same<GetResult_t, const Empty&>::value);
        }

        WHEN("querying for the second type"){
          using GetResult_t = decltype(instance.get(shacl::ebo::index<1>));
          REQUIRE(std::is_same<GetResult_t, const NonEmpty&>::value);
        }
      }
    }
  }
}
