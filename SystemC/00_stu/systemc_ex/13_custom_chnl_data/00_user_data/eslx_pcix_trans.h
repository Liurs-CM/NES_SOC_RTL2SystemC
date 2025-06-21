//FILE: eslx_pcix_trans.h
class eslx_pcix_trans {// previously as struct
    int devnum; // May need get and set methods
    int addr; // and could rename member data to
    int attr1; // match m_ naming conventions.
    int attr2;
    int cmnd;
    int data[8];
    bool done;
    public:
    // Required by sc_signal<> and sc_fifo<>
    eslx_pcix_trans& operator =(
            const eslx_pcix_trans& rhs
            ) {
        devnum = rhs.devnum; addr = rhs.addr;
        attr1 = rhs.attr1; attr2 = rhs.attr2;
        cmnd = rhs.cmnd; done = rhs.done;
        for (unsigned i=0;i!=8;i++) data[i]=rhs.data[i];
        return *this;
    }
    // Required by sc_signal<>
    bool operator==(const eslx_pcix_trans& rhs)
        const {
            return (
                    devnum ==rhs.devnum && addr ==rhs.addr
                    && attr1 ==rhs.attr1 && attr2 ==rhs.attr2
                    && cmnd ==rhs.cmnd && done ==rhs.done
                    && data[0]==rhs.data[0]&& data[1]==rhs.data[1]
                    && data[2]==rhs.data[2]&& data[3]==rhs.data[3]
                    && data[4]==rhs.data[4]&& data[5]==rhs.data[5]
                    && data[6]==rhs.data[6]&& data[7]==rhs.data[7]
                   );
        }
    friend ostream& operator<<(ostream& file,
            const eslx_pcix_trans& trans);
    friend void sc_trace(sc_trace_file*& tf,
            const eslx_pcix_trans& trans,
            string nm);
};
