%module dmc
/* First: Include your own code.*/
%{
#define SWIG_FILE_WITH_INIT
#include "dmc.h"
%}

%include "std_vector.i"

namespace std {
   %template(vector_int) vector<int>;
   %template(vector_double) vector<double>;
   %template(vvector_double) vector<vector<double>>;
};

%include "dmc.h"

