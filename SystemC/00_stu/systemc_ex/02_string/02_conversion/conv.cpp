#define SC_INCLUDE_FX
#include <string>
#include <iostream>
#include <systemc>
using namespace std;
using namespace sc_core;
using namespace sc_dt;

int sc_main(int sc_argc, char* sc_argv[]) {

    sc_int<3> d(3);
    sc_int<5> e(15);
    sc_int<5> f(14);
    sc_int<7> sum = d + e + f;// Works
    sc_int<64> g("0x7000000000000000");
    sc_int<64> h("0x7000000000000000");
    sc_int<64> i("0x7000000000000000");
    sc_bigint<70> bigsum = g + h + i; // Doesn’t work
    bigsum = sc_bigint<70>(g) + h + i;// Works

    //sc_start(); // invoke the simulator
    return 0;
}
