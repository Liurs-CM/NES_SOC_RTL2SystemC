//FILE: Switch.h
SC_MODULE(Switch) {
    sc_port<sc_fifo_in_if<int>
        ,5
        ,SC_ONE_OR_MORE_BOUND
        > T1_ip;
    sc_port<sc_signal_inout_if<bool>
        ,0
        > request_op;
    ...
};
