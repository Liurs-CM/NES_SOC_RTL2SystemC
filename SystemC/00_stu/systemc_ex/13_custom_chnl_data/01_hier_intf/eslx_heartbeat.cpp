#include <systemc>
#include "eslx_heartbeat.h"
void eslx_heartbeat::heartbeat_method(void) {
    m_heartbeat.notify(m_period);
}
