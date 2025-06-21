//FILE: wave.cpp
wave::wave(sc_module_name nm) //Constructor
    : sc_module(nm) {
        …
            tracefile = sc_create_vcd_trace_file("wave");
        sc_trace(tracefile,brake,"brake");
        sc_trace(tracefile,temperature,"temperature");
    }//endconstructor
wave::~wave() {
    sc_close_vcd_trace_file(tracefile);
    cout << "Created wave.vcd" << endl;
}
