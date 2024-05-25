// +FHDR----------------------------------------------------------------------------
// Project Name  : NES_SOC
// Device        : WSL2
// Author        : liurs
// Email         : liurs@njust.edu.cn
// Website       : liurs.cn
// Created On    : 2024/05/17 22:01
// Last Modified : 2024/05/24 00:54
// File Name     : data_matrix_pc_load.v
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

module data_matrix_pc_load(/*autoarg*/
    //Inputs
    clk, rst_n, bus, ea, ld_pc, 
    pc_sel, gate_pc_en, 
    gate_pc_minus_1_en, 
    //Outputs
    reg_pc, pc, pc_minus_one
);
input clk;
input rst_n;
input [15:0] bus;
input [15:0] ea;
input ld_pc;
input [1:0] pc_sel;
input gate_pc_en;
input gate_pc_minus_1_en;
output [15:0] reg_pc;
output [15:0] pc;
output [15:0] pc_minus_one;

reg [15:0] reg_pc;

/*autodef*/
//Start of automatic define
//Start of automatic reg
//Define flip-flop registers here
//Define combination registers here
//REG_DEL: Register reg_pc has been deleted.
//End of automatic reg
//Start of automatic wire
//Define assign wires here
wire [15:0]                     pc_mux                          ;
//Define instance wires here
//End of automatic wire
//End of automatic define

assign pc_mux[15:0] = (pc_sel[1:0]==2'b00) ? reg_pc[15:0] + 1'b1 :
                      (pc_sel[1:0]==2'b01) ? bus[15:0] :
                      ea[15:0];

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
         reg_pc[15:0] <= #`RD 16'h0;
    end
    else if (ld_pc)begin
         reg_pc[15:0] <= #`RD pc_mux[15:0];
    end
end

assign pc[15:0] = gate_pc_en ? reg_pc[15:0] : 16'hzzzz;
assign pc_minus_one[15:0] = gate_pc_minus_1_en ? (reg_pc[15:0]-1'b1) : 16'hzzzz;

endmodule
//Instance .
