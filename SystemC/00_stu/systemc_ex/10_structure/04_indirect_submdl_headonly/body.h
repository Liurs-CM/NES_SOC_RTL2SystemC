//FILE:Body.h
#include "Wheel.h"
SC_MODULE(Body) {
    Wheel* wheel_FL_iptr;
    Wheel* wheel_FR_iptr;
    SC_CTOR(Body) {
        wheel_FL_iptr = new Wheel("wheel_FL_i");
        wheel_FR_iptr = new Wheel("wheel_FR_i");
        // other initialization
    }
};
