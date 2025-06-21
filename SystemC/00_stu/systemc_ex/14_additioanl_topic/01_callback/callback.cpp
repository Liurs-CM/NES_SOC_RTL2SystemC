void top::before_end_of_elaboration(void) {
    // Can add to elaboration here
    // Can setup reporting here
    sc_report_handler::stop_after(SC_ERROR,100);
}
void top::end_of_elaboration(void) {
    this->count++; // count instances
    static bool once(false);
    if (!once) {
        once = true;
        // possible to examine netlist here
    }
}
void top::start_of_simulation(void) {
    // report on counts talled beforehand
    // initialize channels/ports
}
void top::end_of_simulation(void) {
    static bool once(false);
    if (!once) {
        once = true;
        // provide post-processing/cleanup code here
    }
}
