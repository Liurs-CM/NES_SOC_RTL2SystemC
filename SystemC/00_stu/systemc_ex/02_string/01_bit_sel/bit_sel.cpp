#define SC_INCLUDE_FX
#include <string>
#include <systemc>
#include <iostream>
using namespace std;
using namespace sc_core;
using namespace sc_dt;

//int main(){
int sc_main(int sc_argc, char* sc_argv[]) {
    //-------------------------------------------------
    // bit-select and part-select examples
    //-------------------------------------------------
    sc_uint<8> I1 = "0x35"; // 8-bit signed integer
    sc_uint<5> I2 = "0b01010"; // 5-bit signed integer
    sc_uint<4> I3 = 0; // 4-bit signed integer
    sc_uint<16> I4 = 0; // 16-bit signed integer
    I3 = I2.range(3,0); // I3= 0b1010
    I3[2] = true; // I3= 0b1110
    I3[0] = true; // I3= 0b1111
    I4 = (I3, I1.range(7,4), I2(3,0), I1(3,0));
    // I4 = 0x0f3a5 HEX format
    // I4 = 0b01111001110100101 BIN format
    //SC_REPORT_INFO("DEBUG", ("I4 value: " + I4.to_string()).c_str()); // SystemC日志输出    
    cout << I1 << "; " << I2 << "; " << I3;
    cout << " I4= " << I4;
    cout << " I4_HEX= " << I4.to_string(SC_HEX);
    cout << " I4_HEX_US= " << I4.to_string(SC_HEX_US);
    cout << endl;
    return 0;
}
