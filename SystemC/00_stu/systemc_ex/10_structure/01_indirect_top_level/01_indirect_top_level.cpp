//FILE: main.cpp
#include <systemc>
#include "Car.h"
int sc_main(int argc, char* argv[]) {
    Car* car_iptr; // pointer to Car
    car_iptr = new Car("car_i"); // create Car
    sc_start();
    delete car_iptr;
    return 0;
}
