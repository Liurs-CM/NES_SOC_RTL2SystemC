#include <systemc>
using namespace sc_core;

SC_MODULE(Hello_SystemC) { // declare module class
    SC_CTOR(Hello_SystemC) { // create a constructor
        SC_THREAD(main_thread);// register the process
    }//end constructor
    void main_thread(void) {
        SC_REPORT_INFO("info", " Hello SystemC World!");
    }
};
int sc_main(int sc_argc, char* sc_argv[]) {
    //create an instance of the SystemC module
    Hello_SystemC HelloWorld_i("HelloWorld_i");
    sc_start(); // invoke the simulator
    return 0;
}
