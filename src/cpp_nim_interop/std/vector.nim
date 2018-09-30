{.passC: "-std=c++0x".}
type vectornim* {.importcpp: "std::vector", header: "<vector>",nodecl.}[T] = object
type
  VectorIterator {.importcpp: "std::vector<'0>::iterator".} [T] = object
type
  VectorConstIterator {.importcpp: "std::vector<'0>::const_iterator".} [T] = object

proc constructVector*[T](s:csize): vectornim[T] {.importcpp: "std::vector<'0>(@)",constructor, header: "<utility>".}
proc constructVector*[T](): vectornim[T] {.importcpp: "std::vector<'0>()",constructor, header: "<utility>".}
proc constructVector*[T](a:var vectornim[T], b:vectornim[T]): vectornim[T] {.importcpp: "std::vector<'0>(@)",constructor, header: "<utility>".}
proc constructVector*[T]( b:vectornim[T]): vectornim[T] {.importcpp: "std::vector<'0>(@)",constructor, header: "<utility>".}
# iterator items*[T](v: var vector[T]):T =
#     var x = VectorConstIterator[T]()
#     while not finished(x):
#         yield x()

iterator items*[T](v: vectornim[T]):T{.inline.} =
    var i = 0
    while i < v.len():
        yield v[i]
        inc i

proc `[]=`*[T](v: var vectornim[T], key: Natural, val: T) {.importcpp: "#[#] = #", header: "<vector>".}

proc `[]`*[T](v: var vectornim[T], key: Natural): T {.importcpp: "(#[#])".}

proc `[]`*[T](v: vectornim[T], key: Natural): T {.importcpp: "(#[#])".}

proc push_back*[T](v: var vectornim[T], val: T){.importcpp: "#.push_back(@)", header: "<vector>".}

proc size*[T](v:  vectornim[T]):csize{.importcpp: "#.size()", header: "<vector>".}

proc len*[T](v:  vectornim[T]):Natural =
    let s = v.size()
    cast[Natural](s)

proc `$`*[T](v:var vectornim[T]):string =
    result = "["
    for val in v:
        result &= $val & ","
    result[^1]= ']'

proc repr*[T](v:var vectornim[T]):string =
    result = "["
    for val in v:
        result &= $val & ","
    result[^1]= ']'

# converter toVectornim*[T](a:var vectornim[T] ):vectornim[T]{.importcpp:"(reinterpret_cast<std::vector<const '*0>&>(@))",header: "<vector>".}
# converter toVectornim*[T](a: vectornim[T] ):vectornim[T]{.importcpp:"(reinterpret_cast<std::vector<const '*0>&>(@))",header: "<vector>".}

# converter toVectornim*[T](v: seq[T]):vectornim[T] {.noInit.}=
#     result = constructVector[T]()
#     for x in v:
#         result.push_back(x)

# converter toVectornim*[T](v:var seq[T]):vectornim[T] {.noInit.}=
#     result = constructVector[T]()
#     for x in v:
#         result.push_back(x)

converter toSeq*[T](v: var vectornim[T]):seq[T] =
    for x in v:
        result.add x

converter toSeq*[T](v: vectornim[T]):seq[T] =
    for x in v:
        result.add x

when isMainModule:
    var a:vectornim[int]
    a.push_back 1
    a.push_back 2

    assert toSeq(a) == @[1, 2]

    # echo toVectornim(toSeq(a))