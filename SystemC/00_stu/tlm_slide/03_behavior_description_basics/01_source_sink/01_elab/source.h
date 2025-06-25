class source : public sc_module {
    public:
        sc_in_clk clk;
        sc_in<bool> full;
        sc_out<bool> wr_ena;
        sc_out<bool> rst;
        sc_out<char> din;
        sc_signal<unsigned int> data_count;
        SC_HAS_PROCESS(source);
        source(sc_module_name  name) : sc_module(name) {
            SC_CTHREAD(main,clk.neg());
        }
        void main();
        void write(const T& data);
};

void source::main() {
    int i=0;      
    const char str []=
        "For any problems,feel free to contact the  author via Email:chenxiee @mails.tsinghua.edu.cn!\n";      
    wait();
    while (true) {
        if (rand() & 1) { if (str[i]) {write(str[i++]);} }
        wait();
    }
}

void source::write(const T& data) {
    write_data = data;
    do {
        wait(clk->posedge_event());
    } while (full == true);
    wait(clk->posedge_event());
    wr_ena = true;
    wait(clk->posedge_event());	
    wr_ena = false;
}
