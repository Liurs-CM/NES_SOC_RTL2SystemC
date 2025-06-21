#include “Packet.h”
static unsigned changes;
// A function to monitor changes on a Packet
void Packet_cbA(
        scv_extensions_if& obj,
        scv_extensions_if::callback_reason reason
        ) {
    if (reason == scv_extensions_if::VALUE_CHANGE) {
        cout<< "Packet " << obj.get_name()
            << " value change to " << obj.get_unsigned()
            <<endl;
    } else {
        cout<< "Packet " << obj.get_name()
            << " deleted." <<endl;
    }
}
void Packet_cbB(
        scv_extensions_if& obj,
        scv_extensions_if::callback_reason reason
        ) {
    if (reason == scv_extensions_if::VALUE_CHANGE) {
        changes++;
    } else {
        cout<< changes << " distinct values"
            <<endl;
    }
}
scv_smart_ptr<Packet> pPkt1(“pPkt1”),pPkt2(“pPkt2”);
scv_extensions_if::callback_h
h1A(pPkt1->register_cb(Packet_cbA)),
    h1B(pPkt1->register_cb(Packet_cbB)),
    h2A(pPkt2->register_cb(Packet_cbA));
for (int i=0; i!=10; ++i) {
    pPkt1->next(); pPkt2->next();
}
pPkt1->remove_cb(h1A);
