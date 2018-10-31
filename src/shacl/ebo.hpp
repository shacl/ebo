#ifndef SHACL_EBO_HPP
#define SHACL_EBO_HPP

#include <type_traits>

namespace shacl {
namespace ebo {
template<int i>
using Index = std::integral_constant<int, i>;

template<int i>
static constexpr Index<i> index{};

namespace detail {

template<typename T>
static constexpr bool shouldInherit =
  std::is_empty<T>::value and not std::is_final<T>::value;

template<typename... Ts>
struct Implementation;

template<>
struct Implementation<>{
  template<typename...>
  struct type {
    constexpr type() = default;
  };
};

template<typename T, typename... Ts>
struct Implementation<T, Ts...> {
  using Recursion = typename Implementation<Ts...>::template type<>;

  /**
   * Why is there an unused type in this template?
   * =============================================
   *
   * Within the context of a class template definition (in this case the
   * `Implementation` class template), a nested template (e.g.,
   * `Implementation`'s nested `type` class template) may not be fully
   * specialized. To work around this limitation, we introduce an
   * additional (unused) template parmeter and partially specialize.
   *
   **/
  template<typename = void, bool = shouldInherit<T>>
  class type;

  template<typename dummy>
  class type<dummy, true> : Recursion, T {
  public:
    template<typename Arg,
             typename... Args,
             std::enable_if_t
             <std::is_constructible<T, Arg>::value
              and std::is_constructible<Recursion, Args...>::value,
              bool> = true>
    constexpr type(Arg&& arg, Args&&... args) :
      Recursion(std::forward<Args>(args)...),
      T(std::forward<Arg>(arg)){}

  protected:
    constexpr const auto& get(Index<0>) const {
      return static_cast<const T&>(*this);
    }

    /**
     * This method calls into a method that doesn't exist in the base case.
     *
     * Why does this compile?
     * =======================
     *
     * Note that member functions for class templates are only generated
     * if they're used. As such, the nested `type` class of the single
     * parameter instantiation of `Implementation` need not define this
     * method, so long as the function is not invoked.
     *
     **/
    template<int i>
    constexpr const auto& get(Index<i>) const {
      return Recursion::get(Index<i - 1>{});
    }
  };

  template<typename dummy>
  class type<dummy, false> : Recursion {
    T t;

  public:
    template<typename Arg, typename... Args,
             std::enable_if_t
             <std::is_constructible<T, Arg>::value
              and std::is_constructible<Recursion, Args...>::value,
              bool> = true>
    constexpr type(Arg&& arg, Args&&... args) :
      Recursion(std::forward<Args>(args)...),
      t(std::forward<Arg>(arg)){}

  protected:
    constexpr const auto& get(Index<0>) const { return this->t; }

    template<int i>
    constexpr const auto& get(Index<i>) const {
      return Recursion::get(index<i - 1>);
    }
  };
};

} // namespace detail


template<typename T, typename... Ts>
using Type = typename detail::Implementation<T, Ts...>::template type<>;

} // namespace ebo
} // namespace shacl

#endif // #indef SHACL_EBO_HPP
