// note, scv_tr_db instantiated in sc_main.
class simple_transactor : public simple_ports {
    scv_tr_stream read_stream;
    scv_tr_generator<sc_uint<8>, sc_uint<8>> read_tr;
    SC_CTOR(simple_transactor)
        // assign a name and type to your read_stream
        :read_stream(“read_stream”, “transactor”)
         // assign name to this transaction generator
         // associated with the stream, and assign names
         // to the associated attributes.
         ,read_tr(“read”, read_stream, “addr”, “data”)
    {…}

    sc_uint<8> read(sc_uint<8>&* addr) {
        // signals the start of a transaction
        scv_tr_handle xactionHandle =
            read_tr.begin_transaction(addr); 
    }
    sc_uint<32> data;
    //process read …
    // signals the end of the transaction
    read_tr.end_transaction(xactionHandle ,data);
    return data;
}
};
