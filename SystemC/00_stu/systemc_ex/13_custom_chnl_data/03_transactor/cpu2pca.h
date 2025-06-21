#include "CPU_if.h"
#include "eslx_heartbeat_if.h"
class cpu2pca
:public sc_module
    ,public CPU_if
{
    public:
        // Ports
        sc_port<eslx_heartbeat_if> ck; // clock
        sc_out<bool> ld; // load/exec cmd
        sc_out<bool> rw; // read high
                         // write low
        sc_out<unsigned long> a; // address
        sc_inout_rv<32> d; // data
                           // Constructor
        SC_CTOR(cpu2pca):FLOAT("ZZZZZZZZ") {}
        // Interface implementations
        void write(unsigned long addr
                ,long data);
        long read(unsigned long addr);
        // Useful constants
        const sc_lv<32> FLOAT;
    private:
        cpu2pca(const cpu2pca&); // Disable
};
