//CBus.h
#include "CBus_if.h"
class North_bus; // Forward declarations
class South_bus;
class Debug_bus;
class CBus_rtl;
SC_MODULE(CBus) {
    sc_export<CBus_North_if> north_p;
    sc_export<CBus_South_if> south_p;
    SC_CTOR(CBus);
    private:
    North_bus* nbus_ci;
    South_bus* sbus_ci;
    Debug_bus* debug_ci;
    CBus_rtl* rtl_i;
};
