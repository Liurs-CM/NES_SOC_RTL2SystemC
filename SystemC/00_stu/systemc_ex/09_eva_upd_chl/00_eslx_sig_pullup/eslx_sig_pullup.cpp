class eslx_pullup
: public sc_core::sc_signal_resolved {
    public:
        // constructors
        eslx_pullup()
            : sc_signal_resolved(sc_gen_unique_name("pullup"))
        {}
        explicit eslx_pullup(const char* nm)
            : sc_signal_resolved(nm)
        {}
        const sc_dt::sc_logic& read() const {
            const sc_dt::sc_logic& result
                (sc_core::sc_signal_resolved::read());
            static const sc_dt::sc_logic
                ONE(sc_dt::SC_LOGIC_1);
            if (result == sc_dt::SC_LOGIC_Z) {
                return ONE;
            } else {
                return result;
            }//endif
        }
};
