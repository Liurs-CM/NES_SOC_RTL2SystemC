sc_mutex NAME;
NAME.lock(); // Lock the mutex,
             // wait until unlocked if in use
int NAME.trylock(); // Non-blocking, returns success
NAME.unlock(); // Free a previously locked mutex

class car : public sc_module {
    sc_mutex drivers_seat;
    public:
    void drive_thread(void);
    …
};

void car::drive_thread(void) {
    drivers_seat.lock(); // sim driver acquires seat
    start();
    … // operate vehicle
        stop();
    drivers_seat.unlock(); // sim driver leaves
                           // vehicle
    …
}

class bus : public sc_module {
    sc_mutex bus_access;
    …
        void write(int addr, int data) {
            bus_access.lock();
            // perform write
            bus_access.unlock();
        }…
};

