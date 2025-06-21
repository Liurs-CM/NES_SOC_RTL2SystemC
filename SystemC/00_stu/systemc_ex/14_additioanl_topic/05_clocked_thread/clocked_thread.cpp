#include "processor.h"
SC_HAS_PROCESS(processor);
processor::processor(sc_module_name nm)
    //Constructor
    : sc_module(nm)
{
    // Process registration
    SC_CTHREAD(processor_cthread,clock_p.pos());
    reset_signal_is(reset_p, false);
}//endconstructor }}}
class Aborted {}; // used for throwing
#define WAIT_CYCLE \
    wait(); if (abort_p->read()==true) throw Aborted
void processor::processor_cthread() { //{{{
                                      // Initialization
    pc = RESET_ADDR;
    for(;;) {
        try {
            WAIT_CYCLE(); // use instead of wait();
            read_instr();
            switch(opcode) {
                case LOAD_ACC:
                    acc = bus_p->read(operand1);
                    break;
                case STORE_ACC:
                    bus_p->write(operand1,acc);
                    break;
                case INCR:
                    acc++;
                    result = (acc != 0);
                    break;
            } …
        } catch (Aborted) {
            SC_REPORT_WARNING("Aborting");
        }//endtry
    }//endforever
}//endcthread
