//All rights reserved.
//-------------------------
//fifo_ca.h--Cycle accurate fifo by chenxi
//-------------------------
#ifndef _FIFO_CA_H
#define _FIFO_CA_H
 
#include <systemc.h>
//we modeled this FIFO resembling Xilinx FPGA synchronous FIFO IP
template <class T> class fifo_ca : public sc_module {
    public:
        sc_in<bool>  clk;
        sc_in<bool>  rst;  //reset
        sc_in<bool>  wr_en;//write enable
        sc_in<bool>  rd_en;//read enable
        sc_in<T>     din;  //data in
        sc_out<bool> full; 
        sc_out<bool> empty;  
        sc_out<T>    dout;  
        sc_out<unsigned int> data_count;
        SC_HAS_PROCESS(fifo_ca);
           fifo_ca(sc_module_name name, unsigned size)
            : sc_module(name), m_size(size)
        {
            assert(size > 0);
            m_read_pointer = m_write_pointer = 0;
            mem = new T[m_size];
            SC_METHOD(main);
            sensitive << clk.pos()<<rst;
            empty.initialize(true);
            full.initialize(true);  
        }
        ~fifo_ca() { delete[]mem; }

    protected:
        void main() { 
            if (rst==true){
                for (int i=0;i<m_size;i++) {mem[i]=(T) 0;}
                m_read_pointer=0;
                m_write_pointer=0;
                full=false;
                empty=true;
            }
            else {
                if (wr_en.read()) {
                    // store new data item into fifo
                    if(rd_en.read() || (full==false)) {
                        mem[m_write_pointer % m_size] = din.read();
                        m_write_pointer=(m_write_pointer+1)% m_size;
                    }
                }
                if (rd_en.read())    {
                    // discard data item that was just read from fifo
                    if(wr_en.read()|| (empty==false)){
                        dout=mem[m_read_pointer];
                        m_read_pointer = (m_read_pointer + 1) % m_size;
                    }
                }
                // update all output signals        
                data_count=(m_write_pointer-m_read_pointer)%m_size;
                full      =(m_read_pointer-m_write_pointer)==1;
                empty     =m_read_pointer==m_write_pointer;    
            }
        }

    private:
        unsigned m_size;
        unsigned m_read_pointer;   
        unsigned m_write_pointer;
        T* mem;
};
#endif 

