/****fir_fsm.h file****/
SC_MODULE(fir_fsm) {
    sc_in<bool> clock;
    sc_in<bool> reset;
    sc_in<bool> in_valid;
    sc_out<unsigned> state_out;
    // defining the states of the ste machine
    enum {reset_s, first_s, second_s, third_s, output_s,
        wait_s} state;
    SC_CTOR(fir_fsm) {
        SC_METHOD(entry);
        sensitive_pos(clock);
    };
    void entry();
};
