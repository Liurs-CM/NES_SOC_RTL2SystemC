#include <systemc.h>
class sink : public sc_module {
    public:
        sc_in_clk clk;
        sc_port<sc_fifo_in_if<char> > read_port;
        SC_HAS_PROCESS(sink);
        sink(sc_module_name name) : sc_module(name) {
            SC_CTHREAD(main,clk.neg());
        }
        void main(); 
}; 

void sink::main() {
    char c;      
    while (true) {
        if (rand() & 1) {
            read_port->read(c);
            cout << c;
        }
        wait();
    }
}

