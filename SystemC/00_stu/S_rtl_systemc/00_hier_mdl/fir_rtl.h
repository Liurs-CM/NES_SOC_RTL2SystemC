/****fir_rtl.h file****/
#include <systemc.h>
#include "fir_fsm.h"
#include "fir_data.h"
SC_MODULE(fir_rtl) {
    sc_in<bool> clk;
    sc_in<bool> reset;
    sc_in<bool> in_valid;
    sc_in<int> sample;
    sc_out<bool> output_data_ready;
    sc_out<int> result;
    sc_signal<unsigned> state_out;
    fir_fsm *fir_fsm1;
    fir_data *fir_data1;
    SC_CTOR(fir_rtl) {
        fir_fsm1 = new fir_fsm("FirFSM");
        fir_fsm1->clock(clk);
        fir_fsm1->reset(reset);
        fir_fsm1->in_valid(in_valid);
        fir_fsm1->state_out(state_out);
        fir_data1 = new fir_data("FirData");
        fir_data1->state_out(state_out);
        fir_data1->sample(sample);
        fir_data1->clock(clk);
        fir_data1->result(result);
        fir_data1->output_data_ready(output_data_ready);
    }
};
