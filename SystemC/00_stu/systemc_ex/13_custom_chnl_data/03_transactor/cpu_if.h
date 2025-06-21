class CPU_if: public sc_interface {
    public:
        virtual void write(unsigned long addr
                ,long data) = 0;
        virtual long read(unsigned long addr) = 0;
};
