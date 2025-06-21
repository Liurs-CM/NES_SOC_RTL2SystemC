#include<systemc>
using namespace std;
using namespace sc_core;

SC_MODULE(gas_station) {
    sc_event e_request1, e_request2;
    sc_event e_tank_filled;
    SC_CTOR(gas_station) {
        SC_THREAD(customer1_thread);
        sensitive(e_tank_filled); // functional notation
        SC_METHOD(attendant_method);
        sensitive << e_request1 << e_request2; // streaming notation
        //SC_THREAD(customer2_thread);
    }
    void attendant_method();
    void customer1_thread();
    //void customer2_thread();
};

void gas_station::customer1_thread() {
    while (true) {
        sc_time EMPTY_TIME(2,SC_MS);
        wait(EMPTY_TIME);
        cout << "Customer1 needs gas" << endl;
        int m_tank1 = 0;
        do {
            e_request1.notify();
            wait(); // use static sensitivity
        } while (m_tank1 == 0);
    }//endforever
}//end customer1_thread()
 // omitting customer2_thread (almost identical
 // except using wait(e_request2);)

void gas_station::attendant_method() {
    if (!m_filling) {
        cout << "Filling tank" << endl;
        m_filling = true;
        sc_time FILL_TIME(2,SC_MS);
        next_trigger(FILL_TIME);
    } else {
        e_tank_filled.notify(SC_ZERO_TIME);
        cout << "Filled tank" << endl;
        m_filling = false;
    }//endif
}//end attendant_method()

int sc_main(int sc_argc, char* sc_argv[]) {
    bool m_filling = false;
    gas_station my_inst("my_inst");
    sc_start(4,SC_MS); // invoke the simulator
    return 0;
}
