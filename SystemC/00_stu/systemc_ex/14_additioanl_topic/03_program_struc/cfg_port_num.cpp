#include <sstream>
#include "varports.h"
#include "device.h"
class testbench : public sc_module {
    public:
        varports* varports_i;
        device* device_i[N]; //N previously set to
        16
            sc_fifo<int>* v2d[N];
        sc_fifo<int>* d2v[N];
        SC_CTOR(testbench);
};
// Constructor
SC_HAS_PROCESS(testbench);
testbench::testbench(sc_module_name mdl)
    : sc_module(mdl)
{
    /* Figure out N from command-line */
    unsigned nDevices, depth;
    uint_option("-n=",nDevices);//See 2 pages back
    varports_i = new varports(…init parameters…);
    for (unsigned i=0;i!=nDevices;i++) {
        stringstream nm; // for unique instance names
                         // Create instances
        nm.str(""); nm << "device_name_i[" << i << "]";
        device_i[i] = new device(nm.str().c_str());
        nm.str(""); nm << "v2d[" << i << "]";
        v2d[i]=new sc_fifo<int>(nm.str().c_str(),depth);
        nm.str(""); nm << "d2v [" << i << "]";
        d2v[i]=new sc_fifo<int>(nm.str().c_str(),depth);
        // Connect devices to varports using channels
        device_i[i]->rcv_p(*v2d[i]);
        device_i[i]->xmt_p(*d2v[i]);
        varports_i->rcv_p(*d2v[i]);
        varports_i->xmt_p(*v2d[i]);
    }//endfor
}
