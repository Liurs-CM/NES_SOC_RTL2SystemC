#include<systemc>
using namespace std;
using namespace sc_core;
#include "turn_of_events.h"

//FILE: turn_of_events.cpp
void turn_of_events::turn_knob_thread() {
    // This process provides stimulus to the design
    // by way of standard I/O.
    enum directions {STOP='S', OFF='F'};
    char direction; // Selects appropriate indicator
    bool did_stop = false;
    // allow other threads to get into waiting state
    wait(SC_ZERO_TIME);
    while(true) {
        // Sit in an infinite loop awaiting keyboard
        // or STDIN input to drive the stimulus…
        cout << "Signal command: ";
        cin >> direction;
        switch (direction) {
            case STOP:
                // Make sure the other signals are off
                signals_off.notify();
                signal_stop.notify(); // Turn stop light on
                                      // Wait for acknowledgement of indicator
                wait(stop_indicator_on);
                did_stop = true;
                break;
            case OFF:
                // Make the other signals are off
                signals_off.notify();
                if (did_stop) wait(stop_indicator_off);
                did_stop = false;
                break;
        }//endswitch
    }//endforever
}//end turn_knob_thread()

void turn_of_events::stop_signal_thread() {
    while(true) {
        wait(signal_stop);
        cout << "STOPPING !!!!!!" << endl;
        stop_indicator_on.notify();
        wait(signals_off);
        cout << "Stop off ------" << endl;
        stop_indicator_off.notify();
    }//endforever
}//end stop_signal_thread()

int sc_main(int sc_argc, char* sc_argv[]) {
    turn_of_events my_inst("my_inst");
    sc_start(); // invoke the simulator
    return 0;
}
