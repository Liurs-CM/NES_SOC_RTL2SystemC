// +FHDR----------------------------------------------------------------------------
// Project Name  : NES_SOC
// Device        : WSL2
// Author        : liurs
// Email         : liurs@njust.edu.cn
// Website       : liurs.cn
// Created On    : 2024/05/16 22:51
// Last Modified : 2024/05/26 12:25
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
    ready, int_priority, 
    int_vec
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
output [2:0] int_priority;
output [7:0] int_vec;

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

localparam MEM_DEPTH = 255;
localparam MEM_WIDTH = 256;

reg [15:0] kbsr;
reg [15:0] ddr;
reg [15:0] dsr;
reg ready;
reg [7:0] mem[MEM_DEPTH*MEM_WIDTH:0];
wire [7:0]                        int_pl                          ; // WIRE_NEW
/*autodef*/
//Start of automatic define
//Start of automatic reg
//Define flip-flop registers here
reg  [15:0]                     mdr                             ;
reg  [15:0]                     mar                             ;
//Define combination registers here
//End of automatic reg
//Start of automatic wire
//Define assign wires here
wire [15:0]                     mdr_mux                         ;
wire                            ld_kbsr                         ;
wire                            ld_dsr                          ;
wire                            ld_ddr                          ;
wire                            mem_en                          ;
//Define instance wires here
//WIRE_DEL: Wire int_priority has been deleted.
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

genvar i, j;
generate 
    for(i=0;i<MEM_DEPTH;i=i+1) begin: ram_depth
        for(j=0;j<MEM_WIDTH;j=j+2) begin: ram_width
            always@(posedge clk or negedge rst_n) begin
                if(!rst_n)begin
                     mem[i*MEM_WIDTH+j] <= #`RD 8'h0;
                     mem[i*MEM_WIDTH+j+1] <= #`RD 8'h0;
                end
                else if (mem_en && r_w==WRITE && (i*MEM_WIDTH+j)==mar[15:0])begin
                     mem[i*MEM_WIDTH+j] <= #`RD mdr[7:0];
                     mem[i*MEM_WIDTH+j+1] <= #`RD mdr[15:8];
                end
            end
        end
    end
endgenerate

localparam INT_BASE_ADDR = 16'h01_00;
localparam PL_NUM   = 8;
//genvar i;
generate
    for(i=0;i<PL_NUM;i=i+1) begin: intc_pl
        assign int_vec[i] =  (&mem[INT_BASE_ADDR+4'h1+i<<4][7:6]) ||
                            (&mem[INT_BASE_ADDR+4'h3+i<<4][7:6]) ||
                            (&mem[INT_BASE_ADDR+4'h5+i<<4][7:6]) ||
                            (&mem[INT_BASE_ADDR+4'h7+i<<4][7:6]) ||
                            (&mem[INT_BASE_ADDR+4'h9+i<<4][7:6]) ||
                            (&mem[INT_BASE_ADDR+4'hb+i<<4][7:6]) ||
                            (&mem[INT_BASE_ADDR+4'hd+i<<4][7:6]) ||
                            (&mem[INT_BASE_ADDR+4'hf+i<<4][7:6]) ;
    end
endgenerate
assign int_priority[2:0] =  int_vec[7] ? 3'h7 :
                            int_vec[6] ? 3'h6 :
                            int_vec[5] ? 3'h5 :
                            int_vec[4] ? 3'h4 :
                            int_vec[3] ? 3'h3 :
                            int_vec[2] ? 3'h2 :
                            int_vec[1] ? 3'h1 :
                            3'h0;

//integer i;
//initial begin
//    for(i = 0; i<MEM_DEPTH;i=i+2) begin
//        mem[i] <= #`RD 8'h0;
//        mem[i+1] <= #`RD 8'h0;
//    end
//end
//always@(posedge clk or negedge rst_n) begin
//    if (mem_en && r_w==WRITE && i==mar[15:0])begin
//        mem[mar[15:0]] <= #`RD mdr[7:0];
//        mem[mar[15:0]+1] <= #`RD mdr[15:8];
//    end
//end

endmodule
//Instance .
