/***********************************/
/* fifo_rtl.cc implementation file */
#include "systemc.h"
#include "fifo_rtl.h"

void circ_buf::gen_full(){
    if (num_in_buf_next.read() == BUFSIZE)
        full_next = 1;
    else
        full_next = 0;
}

void circ_buf::gen_empty(){
    if (num_in_buf_next.read() == 0)
        empty_next = 1;
    else
        empty_next = 0;
}

void circ_buf::update_regs(){
    if (reset.read() == 1) {
        full = 0;
        empty = 1;
        num_in_buf = 0;
        buf0 = 0;
        buf1 = 0;
        buf2 = 0;
        buf3 = 0;
        data_out = 0;
    }
    else {
        full = full_next;
        empty = empty_next;
        num_in_buf = num_in_buf_next;
        buf0 = buf0_next;
        buf1 = buf1_next;
        buf2 = buf2_next;
        buf3 = buf3_next;
        data_out = data_out_next;
    }
}

void circ_buf::ns_logic(){
    // Default assignments
    buf0_next = buf0;
    buf1_next = buf1;
    buf2_next = buf2;
    buf3_next = buf3;
    num_in_buf_next = num_in_buf;
    data_out_next = 0;
    if (read_fifo.read() == 1) {
        if (num_in_buf.read() != 0) {
            data_out_next = buf0;
            buf0_next = buf1;
            buf1_next = buf2;
            buf2_next = buf3;
            num_in_buf_next = num_in_buf.read() - 1;
        }
    }
    else if (write_fifo.read() == 1) {
        switch(int(num_in_buf.read())) {
            case 0:
                buf0_next = data_in.read();
                num_in_buf_next = num_in_buf.read() + 1;
                break;
            case 1:
                buf1_next = data_in.read();
                num_in_buf_next = num_in_buf.read() + 1;
                break;
            case 2:
                buf2_next = data_in.read();
                num_in_buf_next = num_in_buf.read() + 1;
                break;
            case 3:
                buf3_next = data_in.read();
                num_in_buf_next = num_in_buf.read() + 1;
            default:
                // ignore the write command
                break;
        }
    }
}
