//FILE: eslx_pcix_trans.cpp
#include "eslx_pcix_trans.h"
ostream& operator<<(ostream& os,
        const eslx_pcix_trans& trans)
{
    os << "{" << endl << " "
        << "cmnd: " << trans.cmnd << ", "
        << "attr1:" << trans.attr1 << ", "
        …
        << "done:" << (trans.done?"true":"false")
        << endl << "}";
    return os;
} // end
  // trace function, only required if actually used
void sc_trace(sc_trace_file*& tf,
        const eslx_pcix_trans& trans,
        string nm)
{
    sc_trace(tf, trans.devnum, nm + ".devnum");
    sc_trace(tf, trans.addr, nm + ".addr");
    …
        sc_trace(tf, trans.data[7], nm + ".data[7]");
    sc_trace(tf, trans.done, nm + ".done");
} // end trace
