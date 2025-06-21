SC_MODULE(missing_event) {
    SC_CTOR(missing_event) {
        SC_THREAD(B_thread); // ordered to cause
        SC_THREAD(A_thread); // problems
        SC_THREAD(C_thread);
    }
    void A_thread() {
        a_event.notify(); // immediate!
        cout << "A sent a_event!" << endl;
    }
    void B_thread() {
        wait(a_event);
        cout << "B got a_event!" << endl;
    }
    void C_thread() {
        wait(a_event);
        cout << "C got a_event!" << endl;
    }
    sc_event a_event;
};
