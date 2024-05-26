// +FHDR----------------------------------------------------------------------------
// Project Name  : NES_SOC
// Device        : WSL2
// Author        : liurs
// Email         : liurs@njust.edu.cn
// Website       : liurs.cn
// Created On    : 2024/05/23 23:30
// Last Modified : 2024/05/26 12:29
// File Name     : lc3_top.v
// Description   :
//         
// Copyright (c) 2024 OpenSource Co.,Ltd..
// ALL RIGHTS RESERVED
// 
// ---------------------------------------------------------------------------------
// Modification History:
// Date         By              Version                 Change Description
// ---------------------------------------------------------------------------------
// 2024/05/23   liurs           1.0                     Original
// -FHDR----------------------------------------------------------------------------

module lc3_top(/*autoarg*/
    //Inputs
    clk, rst_n, pad_kbdr, 
    pad_in_dsr, 
    //Outputs
    pad_kbsr, pad_ddr, 
    pad_out_dsr
);
input clk;
input rst_n;
input [15:0] pad_kbdr;
input [15:0] pad_in_dsr;
output [15:0] pad_kbsr;
output [15:0] pad_ddr;
output [15:0] pad_out_dsr;

wire [15:0] ir; // WIRE_NEW
/*autodef*/
//Start of automatic define
//Start of automatic reg
//Define flip-flop registers here
//Define combination registers here
//End of automatic reg
//Start of automatic wire
//Define assign wires here
//Define instance wires here
wire                            reg_n                           ;
wire                            reg_z                           ;
wire                            reg_p                           ;
wire                            acv                             ;
wire                            interrupt                       ; // WIRE_NEW
wire                            ready                           ;
wire                            priv                            ;
wire                            ld_mar                          ;
wire                            ld_mdr                          ;
wire                            ld_ir                           ;
wire                            ld_reg                          ;
wire                            ld_cc                           ;
wire                            ld_pc                           ;
wire                            ld_priv                         ;
wire                            ld_priority                     ;
wire                            ld_saved_ssp                    ;
wire                            ld_saved_usp                    ;
wire                            ld_acv                          ;
wire                            ld_vector                       ;
wire                            gate_pc                         ;
wire                            gate_mdr                        ;
wire                            gate_alu                        ;
wire                            gate_marmux                     ;
wire                            gate_vector                     ;
wire                            gate_pc_m1                      ;
wire                            gate_psr                        ;
wire                            gate_sp                         ;
wire [1:0]                      pcmux                           ;
wire [1:0]                      drmux                           ;
wire [1:0]                      sr1mux                          ;
wire                            addr1mux                        ;
wire [1:0]                      addr2mux                        ;
wire [1:0]                      spmux                           ;
wire                            marmux                          ;
wire                            tablemux                        ;
wire [1:0]                      vecmux                          ;
wire                            psrmux                          ;
wire [1:0]                      aluk                            ;
wire                            mio_en                          ;
wire                            r_w                             ;
wire                            set_priv                        ;
wire [15:0]                     in_mux                          ;
wire [15:0]                     bus                             ;
wire [15:0]                     mdr                             ;
wire [2:0]                      int_priority                    ;
wire [7:0]                      int_vec                         ;
wire [15:0]                     table_vector                    ;
wire                            psr_mux_sel                     ;
wire [2:0]                      reg_prority                     ;
wire [15:0]                     sr1_out                         ;
wire [15:0]                     stack_point                     ;
wire [15:0]                     pc                              ;
wire [15:0]                     alu                             ;
wire [15:0]                     mar                             ;
wire [15:0]                     pc_minus_one                    ;
wire [15:0]                     psr                             ;
wire [15:0]                     sr2_out                         ;
wire [15:0]                     reg_pc                          ;
wire [15:0]                     ea                              ;
wire                            gate_pc_en                      ;
//WIRE_DEL: Wire int has been deleted.
//End of automatic wire
//End of automatic define

    //Instance: /home/liurs/verilog/work/NES_SOC_RTL2SystemC/LC_3/view/de/mdl/ctrl.v
ctrl u_ctrl(/*autoinst*/
        .clk                    (clk                            ), //input
        .rst_n                  (rst_n                          ), //input
        .reg_n                  (reg_n                          ), //input
        .reg_z                  (reg_z                          ), //input
        .reg_p                  (reg_p                          ), //input
        .acv                    (acv                            ), //input
        .interrupt              (interrupt                      ), //input //INST_NEW
        .ready                  (ready                          ), //input
        .ir                     (ir[15:0]                       ), //input[15:0]
        .psr_15                 (priv                           ), //input
        .ld_mar                 (ld_mar                         ), //output
        .ld_mdr                 (ld_mdr                         ), //output
        .ld_ir                  (ld_ir                          ), //output
        .ld_reg                 (ld_reg                         ), //output
        .ld_cc                  (ld_cc                          ), //output
        .ld_pc                  (ld_pc                          ), //output
        .ld_priv                (ld_priv                        ), //output
        .ld_priority            (ld_priority                    ), //output
        .ld_saved_ssp           (ld_saved_ssp                   ), //output
        .ld_saved_usp           (ld_saved_usp                   ), //output
        .ld_acv                 (ld_acv                         ), //output
        .ld_vector              (ld_vector                      ), //output
        .gate_pc                (gate_pc                        ), //output
        .gate_mdr               (gate_mdr                       ), //output
        .gate_alu               (gate_alu                       ), //output
        .gate_marmux            (gate_marmux                    ), //output
        .gate_vector            (gate_vector                    ), //output
        .gate_pc_m1             (gate_pc_m1                     ), //output
        .gate_psr               (gate_psr                       ), //output
        .gate_sp                (gate_sp                        ), //output
        .pcmux                  (pcmux[1:0]                     ), //output[1:0]
        .drmux                  (drmux[1:0]                     ), //output[1:0]
        .sr1mux                 (sr1mux[1:0]                    ), //output[1:0]
        .addr1mux               (addr1mux                       ), //output
        .addr2mux               (addr2mux[1:0]                  ), //output[1:0]
        .spmux                  (spmux[1:0]                     ), //output[1:0]
        .marmux                 (marmux                         ), //output
        .tablemux               (tablemux                       ), //output
        .vecmux                 (vecmux[1:0]                    ), //output[1:0]
        .psrmux                 (psrmux                         ), //output
        .aluk                   (aluk[1:0]                      ), //output[1:0]
        .mio_en                 (mio_en                         ), //output
        .r_w                    (r_w                            ), //output
        .set_priv               (set_priv                       )  //output
        //INST_DEL: Port int has been deleted.
    );

    //Instance: /home/liurs/verilog/work/NES_SOC_RTL2SystemC/LC_3/view/de/mdl/device.v
device u_device(/*autoinst*/
        .clk                    (clk                            ), //input
        .rst_n                  (rst_n                          ), //input
        .gate_mdr_en            (gate_mdr                       ), //input
        .ld_mdr                 (ld_mdr                         ), //input
        .ld_mar                 (ld_mar                         ), //input
        .mio_en                 (mio_en                         ), //input
        .r_w                    (r_w                            ), //input
        .in_mux                 (in_mux[15:0]                   ), //input[15:0]
        .bus                    (bus[15:0]                      ), //input[15:0]
        .kbdr                   (pad_kbdr[15:0]                 ), //input[15:0]
        .kbsr                   (pad_kbsr[15:0]                 ), //output[15:0]
        .ddr                    (pad_ddr[15:0]                  ), //output[15:0]
        .dsr                    (pad_out_dsr[15:0]              ), //output[15:0]
        .mdr_out                (mdr[15:0]                      ), //output[15:0]
        .ready                  (ready                          ), //output
        .int_priority           (int_priority[2:0]              ), //output[2:0]
        .int_vec                (int_vec[7:0]                   )  //output //INST_NEW[7:0]
    );

    //Instance: /home/liurs/verilog/work/NES_SOC_RTL2SystemC/LC_3/view/de/mdl/intc.v
intc u_intc(/*autoinst*/
        .clk                    (clk                            ), //input
        .rst_n                  (rst_n                          ), //input
        .table_mux_sel          (tablemux                       ), //input
        .gate_vector_en         (gate_vector                    ), //input
        .ld_vector              (ld_vector                      ), //input
        .vector_mux             (vecmux[1:0]                    ), //input[1:0]
        .int_vec                (int_vec[7:0]                   ), //input[7:0]
        .table_vector           (table_vector[15:0]             ), //output[15:0]
        .ld_priv                (ld_priv                        ), //input
        .ld_priority            (ld_priority                    ), //input
        .set_priv               (set_priv                       ), //input
        .psr_mux_sel            (psr_mux_sel                    ), //input
        .ld_acv                 (ld_acv                         ), //input
        .int_priority           (int_priority[2:0]              ), //input[2:0]
        .bus                    (bus[15:0]                      ), //input[15:0]
        .priv                   (priv                           ), //output
        .acv                    (acv                            ), //output
        .interrupt              (interrupt                      ), //output //INST_NEW
        .reg_prority            (reg_prority[2:0]               ), //output[2:0]
        .ld_saved_usp           (ld_saved_usp                   ), //input
        .ld_saved_ssp           (ld_saved_ssp                   ), //input
        .sp_mux_sel             (spmux[1:0]                     ), //input[1:0]
        .sr1_reg                (sr1_out[15:0]                  ), //input[15:0]
        .stack_point            (stack_point[15:0]              )  //output[15:0]
        //INST_DEL: Port int has been deleted.
    );

    //Instance: /home/liurs/verilog/work/NES_SOC_RTL2SystemC/LC_3/view/de/mdl/data_matrix.v
data_matrix u_data_matrix(/*autoinst*/
        .gate_pc                (gate_pc                        ), //input
        .gate_mdr               (gate_mdr                       ), //input
        .gate_alu               (gate_alu                       ), //input
        .gate_marmux            (gate_marmux                    ), //input
        .gate_vector            (gate_vector                    ), //input
        .gate_pc_m1             (gate_pc_m1                     ), //input
        .gate_psr               (gate_psr                       ), //input
        .gate_sp                (gate_sp                        ), //input
        .pc                     (pc[15:0]                       ), //input[15:0]
        .mdr                    (mdr[15:0]                      ), //input[15:0]
        .alu                    (alu[15:0]                      ), //input[15:0]
        .mar                    (mar[15:0]                      ), //input[15:0]
        .vec                    (table_vector[15:0]             ), //input[15:0]
        .pc_m1                  (pc_minus_one[15:0]             ), //input[15:0]
        .psr                    (psr[15:0]                      ), //input[15:0]
        .sp                     (stack_point[15:0]              ), //input[15:0]
        .bus                    (bus[15:0]                      )  //output[15:0]
    );
assign psr[15:0] = {priv, 4'b0, reg_prority[2:0] , 5'b0, reg_n, reg_z, reg_p};

    //Instance: /home/liurs/verilog/work/NES_SOC_RTL2SystemC/LC_3/view/de/mdl/data_matrix_alu.v
data_matrix_alu u_data_matrix_alu(/*autoinst*/
        .aluk                   (aluk[1:0]                      ), //input[1:0]
        .gate_alu_en            (gate_alu                       ), //input
        .ir_slice               (ir[5:0]                        ), //input[5:0]
        .sr2                    (sr2_out[15:0]                  ), //input[15:0]
        .sr1                    (sr1_out[15:0]                  ), //input[15:0]
        .alu                    (alu[15:0]                      )  //output[15:0]
    );

    //Instance: /home/liurs/verilog/work/NES_SOC_RTL2SystemC/LC_3/view/de/mdl/data_matrix_effective_address.v
data_matrix_effective_address u_data_matrix_effective_address(/*autoinst*/
        .ir_slice               (ir[10:0]                       ), //input[10:0]
        .ir_mux                 (addr2mux[1:0]                  ), //input[1:0]
        .reg_pc                 (reg_pc[15:0]                   ), //input[15:0]
        .sr1_out                (sr1_out[15:0]                  ), //input[15:0]
        .reg_mux                (addr1mux                       ), //input
        .mar_sel                (marmux                         ), //input
        .gate_mar               (gate_marmux                    ), //input
        .ea                     (ea[15:0]                       ), //output[15:0]
        .mar                    (mar[15:0]                      )  //output[15:0]
    );

    //Instance: /home/liurs/verilog/work/NES_SOC_RTL2SystemC/LC_3/view/de/mdl/data_matrix_ir_load.v
data_matrix_ir_load u_data_matrix_ir_load(/*autoinst*/
        .clk                    (clk                            ), //input //INST_NEW
        .rst_n                  (rst_n                          ), //input //INST_NEW
        .bus                    (bus[15:0]                      ), //input[15:0]
        .ld_ir                  (ld_ir                          ), //input
        .ir                     (ir[15:0]                       )  //output[15:0]
    );

    //Instance: /home/liurs/verilog/work/NES_SOC_RTL2SystemC/LC_3/view/de/mdl/data_matrix_nzp_load.v
data_matrix_nzp_load u_data_matrix_nzp_load(/*autoinst*/
        .clk                    (clk                            ), //input
        .rst_n                  (rst_n                          ), //input
        .ld_cc                  (ld_cc                          ), //input
        .psr_mux_sel            (psr_mux_sel                    ), //input
        .bus                    (bus[15:0]                      ), //input[15:0]
        .reg_n                  (reg_n                          ), //output
        .reg_z                  (reg_z                          ), //output
        .reg_p                  (reg_p                          )  //output
        //INST_DEL: Port gate_psr_en has been deleted.
        //INST_DEL: Port psr_2to0 has been deleted.
    );

    //Instance: /home/liurs/verilog/work/NES_SOC_RTL2SystemC/LC_3/view/de/mdl/data_matrix_pc_load.v
data_matrix_pc_load u_data_matrix_pc_load(/*autoinst*/
        .clk                    (clk                            ), //input
        .rst_n                  (rst_n                          ), //input
        .bus                    (bus[15:0]                      ), //input[15:0]
        .ea                     (ea[15:0]                       ), //input[15:0]
        .ld_pc                  (ld_pc                          ), //input
        .pc_sel                 (pcmux[1:0]                     ), //input[1:0]
        .reg_pc                 (reg_pc[15:0]                   ), //output[15:0]
        .pc                     (pc[15:0]                       ), //output[15:0]
        .pc_minus_one           (pc_minus_one[15:0]             )  //output[15:0]
        //INST_DEL: Port gate_pc_en has been deleted.
        //INST_DEL: Port gate_pc_minus_1_en has been deleted.
    );

    //Instance: /home/liurs/verilog/work/NES_SOC_RTL2SystemC/LC_3/view/de/mdl/data_matrix_reg.v
data_matrix_reg u_data_matrix_reg(/*autoinst*/
        .clk                    (clk                            ), //input
        .rst_n                  (rst_n                          ), //input
        .ir_slice               (ir[11:0]                       ), //input[11:0]
        .bus                    (bus[15:0]                      ), //input[15:0]
        .dr_mux                 (drmux[1:0]                     ), //input[1:0]
        .sr1_mux                (sr1mux[1:0]                   ), //input[1:0]
        .ld_reg                 (ld_reg                         ), //input
        .sr1_out                (sr1_out[15:0]                  ), //output[15:0]
        .sr2_out                (sr2_out[15:0]                  )  //output[15:0]
    );


endmodule
//Instance .
