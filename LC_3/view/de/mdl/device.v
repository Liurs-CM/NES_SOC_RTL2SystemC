// +FHDR----------------------------------------------------------------------------
// Project Name  : NES_SOC
// Device        : WSL2
// Author        : liurs
// Email         : liurs@njust.edu.cn
// Website       : liurs.cn
// Created On    : 2024/05/16 22:51
// Last Modified : 2024/05/18 15:23
// File Name     : device.v
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
module device(/*autoarg*/
    //Inputs
    clk, rst_n, gate_mdr_en, 
    ld_mdr, ld_mar, mio_en, 
    r_w, in_mux, bus, kbdr, 
    //Outputs
    kbsr, ddr, dsr, mdr_out, 
    ready
);

input clk;
input rst_n;
input gate_mdr_en;
input ld_mdr;
input ld_mar;
input mio_en;
input r_w;
input [15:0] in_mux;
input [15:0] bus;
input [15:0] kbdr;
output [15:0] kbsr;
output [15:0] ddr;
output [15:0] dsr;
output [15:0] mdr_out;
output ready;

localparam IN_KBSR = 2'b00; 
localparam IN_KBDR = 2'b01; 
localparam IN_DSR = 2'b10; 
localparam IN_MEM = 2'b11; 

localparam MAR_KBSR = 16'hFE00; 
localparam MAR_KBDR = 16'hFE02; 
localparam MAR_DSR = 16'hFE04; 
localparam MAR_DDR = 16'hFE06; 

localparam WRITE = 1'b1;
localparam READ = 1'b0;

localparam MEM_DEPTH = 2**16-256;

reg [7:0] mem[MEM_DEPTH-1:0];
/*autodef*/
//Start of automatic define
//Start of automatic reg
//Define flip-flop registers here
reg  [15:0]                     mdr                             ;
reg  [15:0]                     mar                             ;
//Define combination registers here
//REG_DEL: Register kbsr has been deleted.
//REG_DEL: Register dsr has been deleted.
//REG_DEL: Register ddr has been deleted.
//End of automatic reg
//Start of automatic wire
//Define assign wires here
wire [15:0]                     mdr_mux                         ;
wire                            ld_kbsr                         ;
wire                            ld_dsr                          ;
wire                            ld_ddr                          ;
wire                            mem_en                          ;
//Define instance wires here
//End of automatic wire
//End of automatic define


assign in_mux[15:0] = (mar[15:0] == MAR_KBSR) ? kbsr[15:0] :
                      (mar[15:0] == MAR_KBDR) ? kbdr[15:0] :
                      (mar[15:0] == MAR_DSR) ? dsr[15:0] :
                      {mem[mar+1], mem[mar]};
assign mdr_mux[15:0] = mio_en ? in_mux[15:0] : bus[15:0];
always@(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
         mdr[15:0] <= #`RD 16'h0;
    end
    else if (ld_mdr)begin
         mdr[15:0] <= #`RD mdr_mux[15:0];
    end
end
assign mdr_out[15:0] = gate_mdr_en ? mdr[15:0] : 16'hzzzz;

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
         ready <= #`RD 1'b1;
    end
    else if (ld_mdr | mem_en)begin
         ready <= #`RD 1'b0;
    end
    else begin
         ready <= #`RD 1'b1;
    end
end

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
         mar[15:0] <= #`RD 16'h0;
    end
    else if (ld_mar)begin
         mar[15:0] <= #`RD bus[15:0];
    end
end

assign ld_kbsr = mio_en && (r_w == WRITE) && (mar[15:0] == MAR_KBSR);
assign ld_dsr = mio_en && (r_w == WRITE) && (mar[15:0] == MAR_DSR);
assign ld_ddr = mio_en && (r_w == WRITE) && (mar[15:0] == MAR_DDR);
assign mem_en = mio_en && 
                (mar[15:0] != MAR_KBSR) && 
                (mar[15:0] != MAR_KBDR) && 
                (mar[15:0] != MAR_DSR) && 
                (mar[15:0] != MAR_DDR);

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
         kbsr[15:0] <= #`RD 16'h0;
    end
    else if (ld_kbsr)begin
         kbsr[15:0] <= #`RD mdr[15:0];
    end
end

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
         dsr[15:0] <= #`RD 16'h0;
    end
    else if (ld_dsr)begin
         dsr[15:0] <= #`RD mdr[15:0];
    end
end

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
         ddr[15:0] <= #`RD 16'h0;
    end
    else if (ld_ddr)begin
         ddr[15:0] <= #`RD mdr[15:0];
    end
end

generate for(i=0;i<MEM_DEPTH;i+2) begin: ram
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n)begin
             mem[i] <= #`RD 8'h0;
             mem[i+1] <= #`RD 8'h0;
        end
        else if (mem_en && r_w==WRITE && i==mar[15:0])begin
             mem[i] <= #`RD mdr[7:0];
             mem[i+1] <= #`RD mdr[15:8];
        end
    end
endgenerate


endmodule
//Instance .
