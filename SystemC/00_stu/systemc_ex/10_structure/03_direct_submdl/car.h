//FILE:Car.h
#include "Body.h"
#include "Engine.h"
SC_MODULE(Car) {
    Body body_i;
    Engine eng_i;
    Car(sc_module_name nm);
};
