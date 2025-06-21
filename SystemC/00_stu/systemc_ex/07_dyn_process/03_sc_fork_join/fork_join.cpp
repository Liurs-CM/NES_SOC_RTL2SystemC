DataStream d1, d2;
SC_FORK
sc_spawn(
        sc_bind(&dut::AXI_xmt,this,sc_ref(d1)), "p1")
,sc_spawn(
        sc_bind(&dut::PCIX_rcv,this,sc_ref(d1)),"p2")
,sc_spawn(
        sc_bind(&dut::USB2,this,sc_ref(d1)), "p3")
,sc_spawn(
        sc_bind(&dut::HT1_xtm,this,sc_ref(d2)), "p4")
,sc_spawn(
        sc_bind(&dut::HT2_rcv,this,sc_ref(d2)), "p5")
SC_JOIN
