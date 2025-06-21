//FILE: two_processes.cpp
void two_processes::wiper_thread(void) {
    while (true) {
        wipe_left();
        wait(500,SC_MS);
        wipe_right();
        wait(500,SC_MS);
    }//endwhile
}
void two_processes::blinker_thread(void) {
    while (true) {
        blinker = true;
        cout << "Blink ON" << endl;
        wait(300,SC_MS);
        cout << "Blink OFF" << endl;
        blinker = false;
        wait(300,SC_MS);
    }//endwhile
}
