/* fifo_rtl.h header file */
#define BUFSIZE 4
#define LOGBUFSIZE 2
#define LOGBUFSIZEPLUSONE 3
SC_MODULE(circ_buf) {
    // Same I/O as behavioral
    sc_in<bool> clk;
    sc_in<bool> read_fifo;
    sc_in<bool> write_fifo;
    sc_in<int> data_in;
    sc_in<bool> reset;
    sc_out<int> data_out;
    sc_out<bool> full;
    sc_out<bool> empty;
    // Internal signals
    sc_signal<int> buf0, buf0_next;
    sc_signal<int> buf1, buf1_next;
    sc_signal<int> buf2, buf2_next;
    sc_signal<int> buf3, buf3_next;
    sc_signal<sc_uint<LOGBUFSIZEPLUSONE> >
        num_in_buf, num_in_buf_next;
    sc_signal<bool> full_next, empty_next;
    sc_signal<int> data_out_next;
    // Declare processes
    void ns_logic(); // Next-state logic
    void update_regs();// Update all registers
    void gen_full(); // Generate a full signal
    void gen_empty(); // Generate an empty signal
                      // Constructor
    SC_CTOR(circ_buf) {
        SC_METHOD(ns_logic);
        sensitive << read_fifo << write_fifo
            << data_in << num_in_buf;
        SC_METHOD(update_regs);
        sensitive_pos << clk;
        SC_METHOD(gen_full);
        sensitive << num_in_buf_next;
        SC_METHOD(gen_empty);
        sensitive << num_in_buf_next;
    }
};
