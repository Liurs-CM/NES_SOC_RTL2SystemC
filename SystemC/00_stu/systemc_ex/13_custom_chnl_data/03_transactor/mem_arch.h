//FILE: mem_arch.h
#include "CPU_if.h"
class mem
: public sc_channel
    , public CPU_if
{
    public:
        // Constructors & Destructor
        explicit mem(sc_module_name nm
                ,unsigned long ba
                ,unsigned sz)
            :sc_channel(nm)
             ,m_base(ba)
             ,m_size(sz)
    { m_mem = new long[m_size]; }
        ~mem() { delete [] m_mem; }
        // Interface Implementations
        virtual void write(unsigned long addr
                ,long data) {
            if (m_start <= addr && addr < m_base+m_size) {
                m_mem[addr-m_base] = data;
            }
        }//end write
        virtual long read(unsigned long addr) {
            if (m_base <= addr && addr < m_base+m_size) {
                return m_mem[addr-m_base];
            } else {
                cout << "ERROR:"<<name()<<"@"<<sc_time_stamp()
                    << ": Illegal address: " << addr << endl;
                sc_stop(); return 0;
            }
        }//end read
    private:
        unsigned long m_base;
        unsigned m_size;
        long* m_mem[];
        mem_arch(const mem_arch&); // Disable
};
