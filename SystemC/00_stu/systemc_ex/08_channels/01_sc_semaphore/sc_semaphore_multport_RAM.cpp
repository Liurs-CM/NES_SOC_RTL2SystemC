class multiport_RAM {
    sc_semaphore read_ports(3);
    sc_semaphore write_ports(2);
    …
        void read(int addr, int& data) {
            read_ports.wait();
            // perform read
            read_ports.post();
        }
    void write(int addr, const int& data) {
        write_ports.wait();
        // perform write
        write_ports.post();
    } …
};//endclass
