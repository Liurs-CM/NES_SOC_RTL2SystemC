// +FHDR----------------------------------------------------------------------------
// Project Name  : NES_SOC
// Device        : WSL2
// Author        : liurs
// Email         : liurs@njust.edu.cn
// Website       : liurs.cn
// Created On    : 2024/05/17 21:33
// Last Modified : 2024/05/21 23:24
// File Name     : data_matrix_nzp_load.v
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

`timescale 1ns/1ps
module data_matrix_nzp_load(/*autoarg*/
    //Inputs
    clk, rst_n, ld_cc, 
    psr_mux_sel, gate_psr_en, 
    bus, 
    //Outputs
    reg_n, reg_z, reg_p, psr
);
input clk;
input rst_n;
input ld_cc;
input psr_mux_sel;
input gate_psr_en;
input [15:0] bus;
output reg_n;
output reg_z;
output reg_p;
output [2:0] psr;

/*autodef*/
//Start of automatic define
//Start of automatic reg
//Define flip-flop registers here
//Define combination registers here
//End of automatic reg
//Start of automatic wire
//Define assign wires here
wire                            n_pc_11                         ;
wire                            z_pc_10                         ;
wire                            p_pc_9                          ;
//Define instance wires here
//End of automatic wire
//End of automatic define
reg reg_n;
reg reg_z;
reg reg_p;

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
         reg_n <= #`RD 1'b0;
         reg_z <= #`RD 1'b0;
         reg_p <= #`RD 1'b0;
    end
    else if(ld_cc) begin
         reg_n <= #`RD n_pc_11;
         reg_z <= #`RD z_pc_10;
         reg_p <= #`RD p_pc_9;
    end
end

assign n_pc_11 = psr_mux_sel ? bus[2] : (bus[15]==1'b1 && !z_pc_10);
assign z_pc_10 = psr_mux_sel ? bus[1] : (|bus[14:0]==1'b0);
assign p_pc_9  = psr_mux_sel ? bus[0] : (bus[15]==1'b0 && !z_pc_10);

assign psr[2:0] = gate_psr_en ? {reg_n, reg_z, reg_p} : 3'bzzz;

endmodule
//Instance .
