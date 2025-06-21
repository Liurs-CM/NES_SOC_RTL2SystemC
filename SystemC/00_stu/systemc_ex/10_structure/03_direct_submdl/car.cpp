//FILE:Car.cpp
#include <systemc>
#include "Car.h"
// Constructor
SC_HAS_PROCESS(Car);
Car::Car(sc_module_name nm)
    : sc_module(nm)
      , body_i("body_i")
      , eng_i("eng_i")
{
    // other initialization
}
