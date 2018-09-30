
import macros
import strutils

template cpptypedef*(n: untyped,name:string,prefix:string) =
  type `n`* {.importcpp: prefix & "::" & name , header: "<" & name & ">",inject.} = object

macro cpptypedef*(n: untyped,prefix:untyped):untyped =
  let prefixStr = prefix.strVal
  let name = n.strVal
  let id = ident(prefixStr & "_" & n.strVal)

  quote do:
    cpptypedef(`id`,`name`,`prefixStr`)

macro cppstdtypedef*(n:untyped):untyped =
    let prefix = "std"
    let name = n.strVal
    quote do:
        cpptypedef(`n`,`prefix`)

when isMainModule:
    discard cppstdtypedef(string)
    var x: std_string