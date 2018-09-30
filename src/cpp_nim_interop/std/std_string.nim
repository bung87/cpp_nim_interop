import strutils
{.passC: "-std=c++0x".}
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "/\"".}
import ../cpputils

cppstdtypedef(string)

proc constructStdString*(s: cstring): std_string {.importcpp: "std::string(@)", constructor, header: "<string>".}

{.compile: "to_cstring.cc".}
proc toCstring*(s: std_string):cstring{.importcpp:"::toCstring(@)",header:"to_cstring.h".}

converter toString*(x:std_string):string =
  $toCstring(x)

proc `$`(x:std_string):string =
    toString(x)

converter tostd_string*(x:cstring):std_string =
  constructStdString(x)

proc repr*(x:std_string):cstring =
  toCstring(x)

when isMainModule:
    let y:std_string = constructStdString("aaa")
    assert y == "aaa"
