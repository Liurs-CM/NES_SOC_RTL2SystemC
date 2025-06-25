/***********************************/
/* fifo_bhv.cc implementation file */
#include "systemc.h"
#include "fifo_bhv.h"
void circ_buf::read_write() {
    // Reset operations
    headp = 0;
    tailp = 0;
    num_in_buf = 0;
    full = false;
    empty = true;
    data_out = 0;
    for (int i = 0; i < BUFSIZE; i++){
        /* synopsys unroll */
        buffer[i] = 0;
    }
    wait();
    // Main loop
    while (true) {
        if (read_fifo.read()) {
            // Check if FIFO is not empty
            if (num_in_buf != 0) {
                num_in_buf--;
                data_out = buffer[headp++];
                full = false;
                if (num_in_buf == 0) empty = true;
            }
            // Ignore read request otherwise
        }
        else if (write_fifo.read()) {
            // Check if FIFO is not full
            if (num_in_buf != BUFSIZE) {
                buffer[tailp++] = data_in;
                num_in_buf++;
                empty = false;
                if (num_in_buf == BUFSIZE) full = true;
            }
            // Ignore write request otherwise
        }
        else { }
        wait();
    }
}
