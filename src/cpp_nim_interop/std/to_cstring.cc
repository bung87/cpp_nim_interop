#include "to_cstring.h"
char*  toCstring( const std::string& s ) {
  std::vector<char> v(s.size()+1);
  memcpy( &v.front(), s.c_str(), s.size() + 1 );
  return v.data();
};
