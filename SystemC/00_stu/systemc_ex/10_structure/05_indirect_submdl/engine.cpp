//FILE: Engine.cpp
#include <systemc>
#include "FuelMix.h"
#include "Exhaust.h"
#include "Cylinder.h"
// Constructor
SC_HAS_PROCESS(Engine);
Engine::Engine(sc_module_name nm)
    : sc_module(nm)
{
    fuelmix_iptr = new FuelMix("fuelmix_i");
    exhaust_iptr = new Exhaust("exhaust_i");
    cyl1_iptr = new Cylinder("cyl1_i");
    cyl2_iptr = new Cylinder("cyl2_i");
    // other initialization
}
