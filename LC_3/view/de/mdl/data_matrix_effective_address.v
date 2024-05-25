// +FHDR----------------------------------------------------------------------------
// Project Name  : NES_SOC
// Device        : WSL2
// Author        : liurs
// Email         : liurs@njust.edu.cn
// Website       : liurs.cn
// Created On    : 2024/05/17 22:29
// Last Modified : 2024/05/24 00:43
// File Name     : data_matrix_effective_address.v
// Description   :
//         
// Copyright (c) 2024 OpenSource Co.,Ltd..
// ALL RIGHTS RESERVED
// 
// ---------------------------------------------------------------------------------
// Modification History:
// Date         By              Version                 Change Description
// ---------------------------------------------------------------------------------
// 2024/05/17   liurs           1.0                     Original
// -FHDR----------------------------------------------------------------------------

module data_matrix_effective_address
(
    /*autoarg*/
    //Inputs
    ir_slice, ir_mux, reg_pc, 
    sr1_out, reg_mux, mar_sel, 
    gate_mar, 
    //Outputs
    ea, mar
);
input [10:0] ir_slice;
input [1:0] ir_mux;
input [15:0] reg_pc;
input [15:0] sr1_out;
input reg_mux;
input mar_sel;
input gate_mar;
output [15:0] ea;
output [15:0] mar;

/*autodef*/
//Start of automatic define
//Start of automatic reg
//Define flip-flop registers here
//Define combination registers here
//End of automatic reg
//Start of automatic wire
//Define assign wires here
wire [15:0]                     ir11_sext                       ;
wire [15:0]                     ir9_sext                        ;
wire [15:0]                     ir6_sext                        ;
wire [15:0]                     addr_ir                         ;
wire [15:0]                     addr_reg                        ;
wire [15:0]                     marmux                          ;
//Define instance wires here
//End of automatic wire
//End of automatic define

assign ir11_sext[15:0] = { {5{ir_slice[10]}}, ir_slice[10:0]};
assign ir9_sext[15:0] = { {7{ir_slice[8]}}, ir_slice[8:0]};
assign ir6_sext[15:0] = { {10{ir_slice[5]}}, ir_slice[5:0]};

assign addr_ir[15:0] = (ir_mux==2'b00) ? ir11_sext[15:0] :
                       (ir_mux==2'b01) ? ir9_sext[15:0] :
                       (ir_mux==2'b10) ? ir6_sext[15:0] :
                       16'h0;

assign addr_reg[15:0] = reg_mux ? reg_pc[15:0] : sr1_out[15:0];

//assign ea = addr_reg + addr_ir<<left_shift;
assign ea[15:0] = addr_reg[15:0] + addr_ir[15:0];

assign marmux[15:0] = mar_sel ? ea : {8'h0, ir_slice[7:0]};
assign mar[15:0] = gate_mar ? marmux[15:0] : 16'hzzzz;

endmodule
//Instance .
