#include <systemc>
SC_MODULE(module_name) {
    MODULE_BODY
};

#define SC_MODULE(module_name) \
struct module_name: public sc_module

#include <systemc>
class module_name : public sc_module {
    public:
        MODULE_BODY
};
