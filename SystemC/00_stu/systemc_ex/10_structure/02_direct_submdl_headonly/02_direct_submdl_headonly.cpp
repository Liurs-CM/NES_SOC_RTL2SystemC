//FILE:Car.h
#include "Body.h"
#include "Engine.h"
SC_MODULE(Car) {
    Body body_i;
    Engine eng_i ;
    SC_CTOR(Car)
        : body_i("body_i") //initialization
          , eng_i("eng_i") //initialization
    {
        // other initialization
    }
};
