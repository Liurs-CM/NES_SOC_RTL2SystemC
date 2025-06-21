//FILE: turn_of_events.h
SC_MODULE(turn_of_events) {
    // Constructor
    SC_CTOR(turn_of_events) {
        SC_THREAD(turn_knob_thread);
        SC_THREAD(stop_signal_thread);
    }
    sc_event signal_stop, signals_off;
    sc_event stop_indicator_on, stop_indicator_off;
    void turn_knob_thread(); // stimulus process
    void stop_signal_thread(); // indicator process
};//endclass turn_of_events
