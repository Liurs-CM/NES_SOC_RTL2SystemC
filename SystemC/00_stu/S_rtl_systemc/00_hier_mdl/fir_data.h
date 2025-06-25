/****fir_data.h file****/
SC_MODULE(fir_data) {
    sc_in<unsigned> state_out;
    sc_in<int> sample;
    sc_out<int> result;
    sc_out<bool> output_data_ready;
    sc_in<bool> clock;
    sc_int<19> acc;
    sc_int<8> shift[16];
    sc_int<9> coefs[16];
    SC_CTOR(fir_data) {
        SC_METHOD(entry);
        sensitive_pos(clock);
    };
    void entry();
};
