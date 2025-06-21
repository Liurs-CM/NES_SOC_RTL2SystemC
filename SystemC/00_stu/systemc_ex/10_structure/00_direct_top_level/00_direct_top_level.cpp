//FILE: main.cpp
#include <systemc>
#include "Car.h"
int sc_main(int argc, char* argv[]) {
    Car car_i("car_i");
    sc_start();
    return 0;
}
