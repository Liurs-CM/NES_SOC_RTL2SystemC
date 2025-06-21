//FILE: module_name.h
SC_MODULE(module_name) {
    SC_HAS_PROCESS(module_name);
    module_name(sc_module_name
            instname[, other_args…])
        : sc_module(instname)
          [, other_initializers]
    {
        CONSTRUCTOR_BODY
    }
};

//separated
//FILE: module_name.h
SC_MODULE(module_name) {
    module_name(sc_module_name
            instname[,other_args…]);
};

//implementation
//FILE: module_name.cpp
SC_HAS_PROCESS(module_name);
module_name::module_name(
        sc_module_name instname[, other_args…])
    : sc_module(instname)
      [, other_initializers]
{
    CONSTRUCTOR_BODY
}
