sc_fifo<ELEMENT_TYPENAME> NAME(SIZE);
NAME.write(VALUE);
NAME.read(REFERENCE);
… = NAME.read() /* function style */
    if (NAME.nb_read(REFERENCE)) { // Non-blocking
                                   // true if success
        …
    }
if (NAME.num_available() == 0)
    wait(NAME.data_written_event());
if (NAME.num_free() == 0)
    next_trigger(NAME.data_read_event());
