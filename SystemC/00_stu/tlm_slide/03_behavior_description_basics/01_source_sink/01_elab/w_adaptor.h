#ifndef __W_ADAPTOR_H__
#define __W_ADAPTOR_H__
template <class T> class W_Adaptor : public sc_module, public sc_fifo_out_if<T> {
    public:
        sc_in_clk clk;
        sc_in<bool> full;
        sc_out<bool> wr_ena;
        sc_out<bool> rst;
        sc_out<char> din;
        sc_signal<unsigned int> data_count;
        SC_HAS_PROCESS(W_Adaptor);
        unsigned int m_size;    

        W_Adaptor(sc_module_name name,unsigned int size) 
            : sc_module(name),m_size(size) {
                rst=true;
                wait(clk.posedge_event());
                wait(20);
                rst=false;
                wait(clk.posedge_event());
            }

        virtual void write(const T& data) {
            write_data = data;
            do {
                wait(clk->posedge_event());
            } while (full == true);
            wait(clk->posedge_event());
            wr_ena = true;
            wait(clk->posedge_event());	
            wr_ena = false;
        }

        virtual int num_free() const { 
            return m_size-data_count;
        } 

        virtual bool nb_write(const T&) { 
            if(full==true) return false; 
            else{
                wr_ena = true;
                wait(clk->posedge_event());
                wr_ena = false;
                return true;
            }
        }

        virtual const sc_event& data_written_event() const { 
            assert(0); return wr_ena.posedge_event();
        }  
};
#endif

