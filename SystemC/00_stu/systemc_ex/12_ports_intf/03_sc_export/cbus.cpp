//FILE: CBus.cpp
#include "CBus.h"
#include "North_bus.h"
#include "South_bus.h"
#include "Debug_bus.h"
#include "CBus_rtl_bus.h"
CBus::CBus(sc_module_name nm): sc_module(nm) {
    // Local instances
    nbus_ci = new North_bus("nbus_ci");
    sbus_ci = new South_bus("sbus_ci");
    debug_ci = new Debug_bus("debug_ci");
    rtl_i = new CBus_rtl("rtl_i");
    // Export connectivity
    north_p(*nbus_ci);
    south_p(*sbus_ci);
    // Implementation connectivity
    …
}
