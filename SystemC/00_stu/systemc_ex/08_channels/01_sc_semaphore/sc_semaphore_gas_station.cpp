SC_MODULE(gas_station) {
    sc_semaphore pump(12);
    void customer1_thread {
        for(;;) {
            // wait till tank empty
            …
                // find an available gas pump
                pump.wait();
            // fill tank & pay
        }
    };
