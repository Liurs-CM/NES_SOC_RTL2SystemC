//File: Packet.h
struct Packet { // user-defined type
    enum type { SIMPLE, EXTENDED };
    type mode;
    sc_uint<16> address;
    sc_uint<32> data;
};
ostream&operator<<(ostream& os, const Packet& p) {
    os<< "{"
        <<((p.mode==p.SIMPLE)?"SIMPLE":"EXTENDED")
        <<hex
        << ":addr ess=0x"
        << p.address
        <<", data=0x" << p.data
        <<"}";
    return os
}
