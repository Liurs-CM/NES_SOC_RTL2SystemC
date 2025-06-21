//FILE: wait_ex.cpp
void wait_ex::my_thread_process(void) {
    wait(10,SC_NS);
    cout << "Now at " << sc_time_stamp() << endl;
    sc_time t_DELAY(2,SC_MS);
    t_DELAY *= 2;
    cout << "Delaying " << t_DELAY<< endl;
    wait(t_DELAY);
    cout << "Now at " << sc_time_stamp()<< endl;
}
