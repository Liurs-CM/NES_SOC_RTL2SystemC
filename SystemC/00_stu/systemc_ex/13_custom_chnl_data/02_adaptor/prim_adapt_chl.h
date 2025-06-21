#include "eslx_interrupt_gen_if.h"
class interrupt2sigbool
: public sc_prim_channel
    , public eslx_interrupt_gen_if
    , public sc_signal_in_if<bool>
{
    public:
        // Constructors
        explicit interrupt2sigbool()
            : sc_prim_channel(
                    sc_gen_unique_name("interrupt2sigbool")) {}
        explicit interrupt2sigbool(sc_module_name nm)
            : sc_prim_channel(nm) {}
        // Methods for eslx_interrupt_gen_if
        void notify() {
            m_delay = SC_ZERO_TIME; request_update(); }
        void notify(sc_time t) {
            m_delay = t; request_update(); }
        // Methods for sc_signal_in_if<bool>
        const sc_event& value_changed_event() const
        { return m_interrupt; }
        const sc_event& posedge_event() const
        { return value_changed_event(); }
        const sc_event& negedge_event() const
        { return value_changed_event(); }
        const sc_event& default_event() const
        { return value_changed_event(); }
        // true if last delta cycle was active
        const bool& read() const {
            m_val = event(); return m_val;
        }
        // Did value change in the previous delta cycle?
        bool event() const {
            return (sc_delta_count() == m_delta+1);
        }
        bool posedge() const { return event(); }
        bool negedge() const { return event(); }
    protected:
        // every update is a change
        void update() {
            m_interrupt.notify(m_delay);
            m_delta = sc_delta_count();
        }
    private:
        sc_event m_interrupt;
        mutable bool m_val;
        sc_time m_delay;
        uint64 m_delta; // delta of last event
                        // Copy constructor so compiler won't create one
        interrupt2sigbool( const interrupt2sigbool& );
};
