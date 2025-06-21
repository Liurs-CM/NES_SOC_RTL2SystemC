//FILE: main.cpp
#include<systemc>
#include "basic_process_ex.h"
using namespace std;
using namespace sc_core;

void basic_process_ex::my_thread_process(void) {
    cout << "my_thread_process executed within "
        << name() //returns sc_module instance name
        << endl;
}

int sc_main(int argc, char* argv[]) { // args unused
    basic_process_ex my_instance("my_instance");
    sc_start();
    return 0; // unconditional success (not recommended)
}
