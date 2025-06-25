/* fifo_bhv.h header file */
#define BUFSIZE 4
#define LOGBUFSIZE 2
#define LOGBUFSIZEPLUSONE 3
SC_MODULE(circ_buf) {
    sc_in_clk clk; // The clock
    sc_in<bool> read_fifo; // Indicate read from FIFO
    sc_in<bool> write_fifo; // Indicate write to FIFO
    sc_in<int> data_in; // Data written to FIFO
    sc_in<bool> reset; // Reset the FIFO
    sc_out<int> data_out; // Data read from the FIFO
    sc_out<bool> full; // Indicate FIFO is full
    sc_out<bool> empty; // Indicate FIFO is empty
    int buffer[BUFSIZE]; // FIFO buffer
    sc_uint<LOGBUFSIZE> headp; // Pointer to FIFO head
    sc_uint<LOGBUFSIZE> tailp; // Pointer to FIFO tail
                               // Counter for number of elements
    sc_uint<LOGBUFSIZEPLUSONE> num_in_buf;
    void read_write(); // FIFO process
    SC_CTOR(circ_buf) {
        SC_CTHREAD(read_write, clk.pos());
        watching(reset.delayed() == true);
    }
};
