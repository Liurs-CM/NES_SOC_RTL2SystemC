include "eslx_heartbeat_if.h"
class eslx_heartbeat
:public sc_channel
    ,public eslx_heartbeat_if {
        public:
            SC_HAS_PROCESS(eslx_heartbeat);
            // Constructor (only one shown)
            explicit eslx_heartbeat(sc_module_name nm
                    ,sc_time _period)
                :sc_channel(nm)
                 ,m_period(_period)
        {
            SC_METHOD(heartbeat_method);
            sensitive << m_heartbeat;
        }
            // User methods
            const sc_event& default_event() const
            { return m_heartbeat; }
            const sc_event& posedge_event() const
            { return m_heartbeat; }
            void heartbeat_method(); // Process
        private:
            sc_event m_heartbeat; // *The* event
            sc_time m_period; // Time between events
                              // Copy constructor so compiler won't create one
            eslx_heartbeat( const eslx_heartbeat& );
    };
