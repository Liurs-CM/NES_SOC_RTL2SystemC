/****fir_data.cpp file****/
#include <systemc.h>
#include "fir_data.h"
void fir_data::entry() {
#include "fir_const_rtl.h"
    sc_int<8> sample_tmp;
    sc_uint<3> state = state_out.read();
    switch (state) {
        case 0:
            sample_tmp = 0;
            acc = 0;
            for (int i=0; i<=15; i++) {
                shift[i] = 0;}
            result.write(0);
            output_data_ready.write(false);
            break;
        case 1 :
            sample_tmp = sample.read();
            acc = sample_tmp*coefs[0];
            acc += shift[14]* coefs[15];
            acc += shift[13]*coefs[14];
            acc += shift[12]*coefs[13];
            acc += shift[11]*coefs[12];
            output_data_ready.write(false);
            break;
        case 2 :
            acc += shift[10]*coefs[11];
            acc += shift[9]*coefs[10];
            acc += shift[8]*coefs[9];
            acc += shift[7]*coefs[8];
            output_data_ready.write(false);
            break;
        case 3 :
            acc += shift[6]*coefs[7];
            acc += shift[5]*coefs[6];
            acc += shift[4]*coefs[5];
            acc += shift[3]*coefs[4];
            output_data_ready.write(false);
            break;
        case 4 :
            acc += shift[2]*coefs[3];
            acc += shift[1]*coefs[2];
            acc += shift[0]*coefs[1];
            for(int i=14; i>=0; i--) {
                shift[i+1] = shift[i];
            };
            shift[0] = sample.read();
            result.write(acc);
            output_data_ready.write(true);
            break;
        case 5 :
            // This state waits for valid input
            output_data_ready.write(false);
            break;
        default :
            output_data_ready.write(false);
            result.write(0);
    }
}
