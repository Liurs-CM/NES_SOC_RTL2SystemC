/****fir_fsm.cpp file****/
#include <systemc.h>
#include "fir_fsm.h"
void fir_fsm::entry() {
    sc_uint<3> state_tmp;
    // reset behavior
    if(reset.read()==true) {
        state = reset_s;
    }
    // main state machine
    switch(state) {
        case reset_s:
            state = wait_s;
            state_tmp = 0;
            state_out.write(state_tmp);
            break;
        case first_s:
            state = second_s;
            state_tmp = 1;
            state_out.write(state_tmp);
            break;
        case second_s:
            state = third_s;
            state_tmp = 2;
            state_out.write(state_tmp);
            break;
        case third_s:
            state = output_s;
            state_tmp = 3;
            state_out.write(state_tmp);
            break;
        case output_s:
            state = wait_s;
            state_tmp = 4;
            state_out.write(state_tmp);
            break;
        default:
            if(in_valid.read()==true) {
                state = first_s;
            };
            state_tmp = 5;
            state_out.write(state_tmp);
            break;
    }
}
