class my_interface {
    public:
        virtual void write(unsigned addr, int data) = 0;
        virtual int read(unsigned addr) = 0;
};

class multiport_memory_arch: public my_interface {
    public:
        void write(unsigned addr, int data) {
            mem[addr] = data;
        }// end write
        int read(unsigned addr) ) {
            return mem[addr];
        }//end read
    private:
        int mem[1024];
};

class multiport_memory_RTL: public my_interface {
    public:
        void write(unsigned addr, int data) {
            // complex details of RTL memory write
        }// end write
        int read(unsigned addr) ) {
            // complex details of RTL memory read
        }// end read
    private:
        // complex details of RTL memory storage
};

void memtest(my_interface& mem) {
    // complex memory test
}
multiport_memory_arch fast;
multiport_memory_RTL slow;
memtest(fast);
memtest(slow);
