#include "eslx_interrupt_evt_if.h"
#include "eslx_interrupt_gen_if.h"
class eslx_interrupt
: public sc_prim_channel
    , public eslx_interrupt_evt_if
    , public eslx_interrupt_gen_if
{
    public:
        // Constructors
        explicit eslx_interrupt()
            :sc_prim_channel(
                    sc_gen_unique_name("eslx_interrupt"))
    {}//end constructor
        explicit eslx_interrupt(sc_module_name nm)
            :sc_prim_channel(nm)
        {} //end constructor
           // Methods
        void notify() { m_interrupt.notify(); }
        void notify(sc_time t) { m_interrupt.notify(t); }
        const sc_event& default_event() const
        { return m_interrupt; }
    private:
        sc_event m_interrupt;
        // Copy constructor so compiler won't create one
        eslx_interrupt( const eslx_interrupt& rhs)
        {} //end copy constructor
};
