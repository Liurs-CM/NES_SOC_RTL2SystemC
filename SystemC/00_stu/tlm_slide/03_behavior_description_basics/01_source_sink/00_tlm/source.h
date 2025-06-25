class source : public sc_module {
    public:
        sc_in_clk clk;
        sc_port<sc_fifo_out_if<char> > write_port;
        SC_HAS_PROCESS(source);
        source(sc_module_name  name) : sc_module(name) {
            SC_CTHREAD(main,clk.neg());
        }
        void main();
};

void source::main() {
    int i=0;      
    const char str []=
        "For any problems,feel free to contact the  author via Email:chenxiee @mails.tsinghua.edu.cn!\n";      
    wait();
    while (true) {
        if (rand() & 1) { if (str[i]) {write_port->write(str[i++]);} }
        wait();
    }
}

