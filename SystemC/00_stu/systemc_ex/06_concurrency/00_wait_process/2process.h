//FILE: two_processes.h
SC_MODULE(two_processes) {
    void wiper_thread(void); // process
    void blinker_thread(void); // process
    SC_CTOR(two_processes) {
        SC_THREAD(wiper_thread); // register process
        SC_THREAD(blinker_thread); // register process
    }
};
