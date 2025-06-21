//File: Packet_ext.h
#include "Packet.h"
// Extend above user-defined type as follows:
SCV_EXTENSIONS(Packet) {
    public:
        scv_extensions<sc_uint<16>> address;
        scv_extensions<sc_uint<32>> data;
        SCV_EXTENSIONS_CTOR(Packet) {
            SCV_FIELD(address);
            SCV_FIELD(data);
        }
        bool has_valid_extensions() { return true; }
};
