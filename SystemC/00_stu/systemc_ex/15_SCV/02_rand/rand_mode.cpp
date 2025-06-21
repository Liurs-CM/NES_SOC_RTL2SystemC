class Pkt_constraint
: virtual public scv_constraint_base
{
    public:
        scv_smart_ptr<sc_uint<16>> address;
        scv_smart_ptr<sc_uint<32>> data;
        SCV_CONSTRAINT_CTOR(Pkt_constraint) {
            // define constraints
            SCV_CONSTRAINT(
                    (address() != 0x00000000) &&
                    (address() < 0x00001000));
            SCV_CONSTRAINT(data() >= 0x1000);
        }
};
void test() {
    typedef pair <sc_uint<32> , sc_u int<32>> data_range;
    scv_bag<data_range> data_dist;
    //set range distribution for data
    //data range (0x1000, 0xffff) occurs 30%
    //data range (0x10000, 0x20000) occurs 70%)
    data_dist.add(data_range(0x1000, 0xffff),30);
    data_dist.add(data_range(0x10000, 0x20000), 70);
    Pkt_constraint cPkt;
    cPkt.next(); //generate addr and data using
                 //constraints
    cPkt.data->set_mode(data_dist);
    cPkt.next(); //generate addr using
                 //constraints and generate
                 //data using ‘data_dist’
                 //distribution
}
