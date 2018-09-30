type vector* {.importcpp: "std::vector", header: "<vector>".}[T] = object
type
  VectorIterator {.importcpp: "std::vector<'0>::iterator".} [T] = object
type
  VectorConstIterator {.importcpp: "std::vector<'0>::const_iterator".} [T] = object

iterator items*[T](v: var vector[T]):T =
    var x:VectorConstIterator[T]
    var i = 0
    while i < v.size():
        yield v[i]
        inc i

template `[]=`*[T](v: var vector[T], key: int, val: T) =
  {.emit: [v, "[", key, "] = ", val, ";"].}

proc `[]`*[T](v: var vector[T], key: int): T {.importcpp: "(#[#])", nodecl.}

proc push_back*[T](v: var vector[T], val: T){.importcpp: "#.push_back(@)", header: "<vector>".}

proc size*[T](v:  vector[T]):int{.importcpp: "#.size()", header: "<vector>".}

proc `$`*[T](v:var vector[T]):string =
    result = "["
    for val in v:
        result &= $val & ","
    result[^1]= ']'

proc repr*[T](v:var vector[T]):string =
    result = "["
    for val in v:
        result &= $val & ","
    result[^1]= ']'

converter toSeq*[T](v: var vector[T]):seq[T] =
    for x in v:
        result.add x

converter toSeq*[T](v: vector[T]):seq[T] =
    for x in v:
        result.add x

converter toVector*[T](v: seq[T]):vector[T] =
    for x in v:
        result.push_back(x)

converter toVector*[T](v:var seq[T]):vector[T] =
    for x in v:
        result.push_back(x)

when isMainModule:
    var a:vector[int]
    # a[0] = 1 
    a.push_back 1
    a.push_back 2

    assert toSeq(a) == @[1, 2]
    echo toVector( @[1, 2])
