#include <systemc.h>
#include "top.h"
int sc_main (int, char **) {
    unsigned size= 16;
    Top Top1("Top1", size); 
    cout <<"Testbench started,the simulation result is:" << endl;
    sc_start(100000, SC_NS);  
    cout<<"\n"<<endl;
    return 0;
}


