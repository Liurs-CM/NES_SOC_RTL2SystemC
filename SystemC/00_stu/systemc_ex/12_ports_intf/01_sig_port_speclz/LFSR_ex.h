//FILE: LFSR_ex.h
SC_MODULE(LFSR_ex) {
    // Ports
    sc_in<bool> sample;
    sc_out<sc_int<32>> signature;
    sc_in<bool> clock;
    sc_in<bool> reset;
    // Constructor
    SC_CTOR(LFSR_ex) {
        // Register process
        SC_METHOD(LFSR_ex_method);
        sensitive<< clock.pos() << reset;
        signature.initialize(0);
    }
    // Process declarations & Local data
    void LFSR_ex_method();
    sc_int<32> LFSR_reg;
};
