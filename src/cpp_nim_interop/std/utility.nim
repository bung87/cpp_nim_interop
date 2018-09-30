type pair* {.importcpp: "std::pair", header: "<utility>".}[T, U] = object
    first*:T
    second*:U

# proc constructPair*[T,U](a:T,b:U): pair[T, U] {.importcpp: "std::pair[@](@)", constructor, header: "<utility>".}

proc constructPair*[T,U](a:T,b:U): pair[T, U] {.importcpp: "std::make_pair(@)", header: "<utility>".}

converter toTuple*[T,U](x:pair[T,U]):tuple[first:T,second:U] =
  (first:x.first,second:x.second)

converter toPair*[T,U](x:tuple[first:T,second:U]):pair[T,U] =
  constructPair(x.first,x.second)

when isMainModule:
    var x:pair[int,string]
    x.first = 0
    x.second = "a"
    assert toTuple(x) == (first: 0, second: "a")
    let a = (first: 0, second: "a")
    assert toPair(a) ==  (first: 0, second: "a")