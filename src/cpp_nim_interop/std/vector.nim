type vector* {.importcpp: "std::vector", header: "<vector>".}[T] = object

template `[]=`*[T](v: var vector[T], key: int, val: T) =
  {.emit: [v, "[", key, "] = ", val, ";"].}

proc `[]`*[T](v: var vector[T], key: int): T {.importcpp: "(#[#])", nodecl.}
