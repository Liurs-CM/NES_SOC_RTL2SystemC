// +FHDR----------------------------------------------------------------------------
// Project Name  : NES_SOC
// Device        : WSL2
// Author        : liurs
// Email         : liurs@njust.edu.cn
// Website       : liurs.cn
// Created On    : 2024/05/16 22:46
// Last Modified : 2024/05/24 00:57
// File Name     : data_matrix.v
// Description   :
//         
// Copyright (c) 2024 OpenSource Co.,Ltd..
// ALL RIGHTS RESERVED
// 
// ---------------------------------------------------------------------------------
// Modification History:
// Date         By              Version                 Change Description
// ---------------------------------------------------------------------------------
// 2024/05/16   liurs           1.0                     Original
// -FHDR----------------------------------------------------------------------------

`timescale 1ns/1ps
module data_matrix(/*autoarg*/
    //Inputs
    gate_pc, gate_mdr, gate_alu, 
    gate_marmux, gate_vector, 
    gate_pc_m1, gate_psr, 
    gate_sp, pc, mdr, alu, 
    mar, vec, pc_m1, psr, sp, 
    //Outputs
    bus
);

input gate_pc;
input gate_mdr;
input gate_alu;
input gate_marmux;
input gate_vector;
input gate_pc_m1;
input gate_psr;
input gate_sp;

input [15:0] pc;
input [15:0] mdr;
input [15:0] alu;
input [15:0] mar;
input [15:0] vec;
input [15:0] pc_m1;
input [15:0] psr;
input [15:0] sp;
output [15:0] bus;

localparam BUS_PC   = 8'b0000_0001;
localparam BUS_MDR  = 8'b0000_0010;
localparam BUS_ALU  = 8'b0000_0100;
localparam BUS_MAR  = 8'b0000_1000;
localparam BUS_VEC  = 8'b0001_0000;
localparam BUS_PC_M1= 8'b0010_0000;
localparam BUS_PSR  = 8'b0100_0000;
localparam BUS_SP   = 8'b1000_0000;

reg [15:0] bus;

/*autodef*/
//Start of automatic define
//Start of automatic reg
//Define flip-flop registers here
//Define combination registers here
//End of automatic reg
//Start of automatic wire
//Define assign wires here
wire [7:0]                      gate_bus                        ;
//Define instance wires here
//End of automatic wire
//End of automatic define

assign gate_bus[7:0] = {gate_sp, gate_psr, gate_pc_m1, gate_vector, gate_marmux, gate_alu, gate_mdr, gate_pc};

always@(*) begin
    case(gate_bus[7:0])
        BUS_PC:     bus[15:0] = pc[15:0];
        BUS_MDR:    bus[15:0] = mdr[15:0];
        BUS_ALU:    bus[15:0] = alu[15:0];
        BUS_MAR:    bus[15:0] = mar[15:0];
        BUS_VEC:    bus[15:0] = vec[15:0];
        BUS_PC_M1:  bus[15:0] = pc_m1[15:0];
        BUS_PSR:    bus[15:0] = psr[15:0];
        BUS_SP:     bus[15:0] = sp[15:0];
        default:    bus[15:0] = 16'hzzzz;
    endcase
end


endmodule
//Instance .
