SC_MODULE(clock_gen) {
    sc_export<sc_signal_inout_if<bool> > clkout_p;
    sc_port<sc_signal_inout_if<bool> > clkdiv_p;
    sc_clock clk;
    SC_CTOR(clock_gen)
        : clk("clk",sc_time(6,SC_NS))
    {
        SC_METHOD(clk_method);
        sensitive << clk.posedge_event();
        clkout_p(clk);
    }
    void clk_method() {
        clkdiv_p->write(!clkdiv_p->read());
    }
};
