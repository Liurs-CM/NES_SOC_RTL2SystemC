#define SC_INCLUDE_FX
#include <string>
#include <iostream>
#include <systemc>
using namespace std;
using namespace sc_core;
using namespace sc_dt;

int sc_main(int sc_argc, char* sc_argv[]) {
//-------------------------------------------------
// sc_lv<8> 8-bit logic vectors
//-------------------------------------------------
sc_lv<8> LV1;
LV1 = 15;
cout << " LV1= " << LV1;
sc_lv<8> LV2("0101xzxz"); // literal string init
cout << " LV2= " << LV2;
cout << endl;
//-------------------------------------------------
// sc_int<5> 5-bit signed integer
//-------------------------------------------------
sc_int<5> Int1; // 5-bit signed integer
Int1 = "-0d13"; // assign -13
cout << " Int1=" << Int1;
cout << " SC_BIN=" << Int1.to_string(SC_BIN);
cout << " SC_BIN_SM=" << Int1.to_string(SC_BIN_SM);
cout << " " << endl;
cout << " SC_HEX=" << Int1.to_string(SC_HEX);
cout << endl;
//-------------------------------------------------
// sc_fixed<5,3> fixed 3-bit int & 2 bit fraction
//-------------------------------------------------
sc_fixed<5,3> fix1; // fixed point
fix1 = -3.3;
cout << " fix1=" <<fix1;
cout << " SC_BIN=" << fix1.to_string(SC_BIN);
cout << " SC_HEX=" << fix1.to_string(SC_HEX);
cout << endl;

    //sc_start(); // invoke the simulator
    return 0;
}
