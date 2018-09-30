type pair* {.importcpp: "std::pair", header: "<utility>".}[T, U] = object
    first*:T
    second*:U