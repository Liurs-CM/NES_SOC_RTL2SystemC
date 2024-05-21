// +FHDR----------------------------------------------------------------------------
// Project Name  : NES_SOC
// Device        : WSL2
// Author        : liurs
// Email         : liurs@njust.edu.cn
// Website       : liurs.cn
// Created On    : 2024/05/20 22:57
// Last Modified : 2024/05/22 00:25
// File Name     : intc.v
// Description   :
//         
// Copyright (c) 2024 OpenSource Co.,Ltd..
// ALL RIGHTS RESERVED
// 
// ---------------------------------------------------------------------------------
// Modification History:
// Date         By              Version                 Change Description
// ---------------------------------------------------------------------------------
// 2024/05/20   liurs           1.0                     Original
// 2024/05/22   liurs           1.1                     Add Priv, ACV, Priority, SP
// -FHDR----------------------------------------------------------------------------

module intc(/*autoarg*/
    //Inputs
    clk, rst_n, table_mux_sel, 
    gate_vector_en, ld_vector, 
    vector_mux, bus_ir, 
    int_vec, ld_priv, 
    ld_priority, set_priv, 
    psr_mux_sel, gate_psr, 
    ld_acv, bus_15, bus_10to8, 
    int_priority, 
    ld_saved_usp, 
    ld_saved_ssp, gate_sp_en, 
    sp_mux_sel, sr1_reg, 
    //Outputs
    table_vector, priv, acv, 
    psr_15, int, psr_10to8, 
    stack_point
);

//table and vector
input clk;
input rst_n;
input table_mux_sel;
input gate_vector_en;
input ld_vector;
input [1:0] vector_mux;
input [7:0] bus_ir;
input [7:0] int_vec;
output [15:0] table_vector;
//privilege, access control violation and interrupt priority
input ld_priv;
input ld_priority;
input set_priv;
input psr_mux_sel;
input gate_psr;
input ld_acv;
input bus_15;
input [2:0] bus_10to8;
input [2:0] int_priority;
output priv;
output acv;
output psr_15;
output int;
output [2:0] psr_10to8;
//stack point
input ld_saved_usp;
input ld_saved_ssp;
input gate_sp_en;
input [1:0] sp_mux_sel;
input [15:0] sr1_reg;
output [15:0] stack_point;

localparam SP_SAVED_USP = 2'b00;
localparam SP_PLUS_ONE  = 2'b01;
localparam SP_MINUS_ONE = 2'b10;
//localparam SP_SAVED_SSP = 2'b11;

/*autodef*/
//Start of automatic define
//Start of automatic reg
//Define flip-flop registers here
reg  [7:0]                      tab                             ;
reg  [7:0]                      vector                          ;
reg  [2:0]                      reg_prority                     ;
reg  [15:0]                     saved_usp                       ; // REG_NEW
reg  [15:0]                     saved_ssp                       ; // REG_NEW
//Define combination registers here
//End of automatic reg
//Start of automatic wire
//Define assign wires here
wire [7:0]                      tab_wire                        ;
wire [7:0]                      vec_wire                        ;
wire [2:0]                      prority_mux                     ;
wire                            user_sel                        ;
wire                            acv_wire                        ;
wire                            priv_mux                        ;
wire [15:0]                     sp_mux                          ; // WIRE_NEW
//Define instance wires here
//End of automatic wire
//End of automatic define

//table and vector
assign table_vector[15:0] =gate_vector_en ? {tab[7:0], vector[7:0]} : 16'hzzzz;
assign tab_wire[7:0] = table_mux_sel ? 8'h01 : 8'h00;
assign vec_wire[7:0] = !table_mux_sel ? bus_ir[7:0] : 
                       (vector_mux==2'b00) ? 8'h02 :
                       (vector_mux==2'b01) ? 8'h01 :
                       (vector_mux==2'b10) ? 8'h00 :
                       int_vec[7:0];
always@(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
         tab[7:0] <= #`RD 8'h0;
         vector[7:0] <= #`RD 8'h0;
    end
    else if (ld_vector)begin
         tab[7:0] <= #`RD tab_wire[7:0];
         vector[7:0] <= #`RD vec_wire[7:0];
    end
end

//prority
assign prority_mux[2:0] = psr_mux_sel ? bus_10to8[2:0] : int_priority[2:0];
always@(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
         reg_prority[2:0] <= #`RD 3'b0;
    end
    else if (ld_priority)begin
         reg_prority[2:0] <= #`RD prority_mux[2:0];
    end
end
assign int = (int_priority[2:0] > reg_prority[2:0]) ? 1'b1 : 1'b0;
assign psr_10to8[2:0] = gate_psr_en ? reg_prority[2:0] : 3'bzzz;

//acv
//assign system_sel  = (addr[15:12] < 4'h3); //system space:    0x0000~0x2FFF
assign user_sel = (addr[15:12] >= 4'h3) && (addr[15:8] < 8'hFE); //user space:    0x3000~0xFDFF
//assign device_sel  = (addr[15:8] >= 8'hFE); //device space:   0x0000~0x2FFF
assign acv_wire = priv && user_sel; 
always@(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
         acv <= #`RD 1'b0;
    end
    else if (ld_acv)begin
         acv <= #`RD acv_wire;
    end
end

//priv
assign priv_mux = psr_mux_sel ? bus_15 : set_priv;
always@(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
         priv <= #`RD 1'b0;
    end
    else if (ld_priv)begin
         priv <= #`RD priv_mux;
    end
end
assign psr_15 = gate_psr_en ? priv : 1'bz;

//stack point
always@(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
         saved_usp[15:0] <= #`RD 16'h0;
    end
    else if (ld_saved_usp)begin
         saved_usp[15:0] <= #`RD sr1_reg[15:0];
    end
end

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
         saved_ssp[15:0] <= #`RD 16'h0;
    end
    else if (ld_saved_ssp)begin
         saved_ssp[15:0] <= #`RD sr1_reg[15:0];
    end
end

assign sp_mux[15:0] = (sp_mux_sel==SP_SAVED_USP)   ? saved_usp[15:0] :
                           (sp_mux_sel==SP_PLUS_ONE)    ? sr1_reg[15:0] + 1 :
                           (sp_mux_sel==SP_MINUS_ONE)   ? sr1_reg[15:0] - 1 :
                           saved_usp[15:0];
assign stack_point[15:0] = gate_sp_en ? sp_mux[15:0] : 16'hzzzz;


endmodule
//Instance .
