//FILE: Fork.h
SC_MODULE(Fork) {
    …
    sc_fifo<double> wheel_lf, wheel_rt;
    SC_CTOR(Fork);// Constructor
    // Declare processes to be used with fork/join
    void fork_thread();
    bool road_thread(sc_fifo<double>& which);
};
