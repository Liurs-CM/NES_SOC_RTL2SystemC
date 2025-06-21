void grab_bus_method() {
    if (bus_access.trylock() == 0) {
        // access bus
        …
            bus_access.unlock();
    }
}
