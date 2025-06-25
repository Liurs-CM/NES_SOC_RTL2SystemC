class tlm_fifo: public sc_module,  public sc_fifo_in_if<T>,
    public sc_fifo_out_if<T>,   public reset_if
{
    public:
        sc_in<bool>     clk;
        ……//Other Signal Declaration   
          //FIFO in FIFO, rtl_fifo1 is an embedded channel
            rtl_fifo<T> rtl_fifo1;//RTL FIFO
    private:  
        unsigned m_size;//actual size of FIFO
    public:
           tlm_fifo(sc_module_name name, unsigned size)
            : sc_module(name), rtl_fifo1("rtl_fifo1", size+1),m_size(size)
        {
            assert(m_size>0);  
            rtl_fifo1.clk(clk);    rtl_fifo1.rst(rst);
            ……//Other port assiciation
        }  

        virtual void tlm_fifo::write(const T& data)
        {
    write_data = data;
    do { wait(clk->posedge_event());} while (full == true);
    wait(clk->posedge_event());
    write_enable = true;
    wait(clk->posedge_event());	
    write_enable = false;
   }

