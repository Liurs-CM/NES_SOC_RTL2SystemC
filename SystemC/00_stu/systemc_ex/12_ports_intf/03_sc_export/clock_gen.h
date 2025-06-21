SC_MODULE(modulename) {
    sc_export<interface> portname;
    channel cinstance;
    SC_CTOR(modulename) {
        portname(cinstance);
    }
};

SC_MODULE(clock_gen) {
    sc_export<sc_signal<bool>> clock_xp;
    sc_signal<bool> oscillator;
    SC_CTOR(clock_gen) {
        SC_METHOD(clock_method);
        clock_xp(oscillator); // connect sc_signal
                              // channel
                              // to export clock_xp
        oscillator.write(false);
    }
    void clock_method() {
        oscillator.write(!oscillator.read());
        next_trigger(10,SC_NS);
    }
};
