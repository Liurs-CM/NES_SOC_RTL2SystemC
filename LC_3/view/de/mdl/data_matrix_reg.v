// +FHDR----------------------------------------------------------------------------
// Project Name  : NES_SOC
// Device        : WSL2
// Author        : liurs
// Email         : liurs@njust.edu.cn
// Website       : liurs.cn
// Created On    : 2024/05/17 23:43
// Last Modified : 2024/05/24 01:00
// File Name     : data_matrix_reg.v
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

module data_matrix_reg(/*autoarg*/
    //Inputs
    clk, rst_n, ir_slice, bus, 
    dr_mux, sr1_mux, ld_reg, 
    //Outputs
    sr1_out, sr2_out
);
input clk;
input rst_n;
input [11:0] ir_slice;
input [15:0] bus;
input [1:0] dr_mux;
input [1:0] sr1_mux;
input ld_reg;
output [15:0] sr1_out;
output [15:0] sr2_out;

localparam DRMUX_IR = 2'b00;
localparam DRMUX_R6 = 2'b01;
//localparam DRMUX_R7 = 2'b1x;
localparam SR1MUX_IR_H = 2'b00;
localparam SR1MUX_IR_L = 2'b01;
//localparam SR1MUX_R6 = 2'b1x;

reg [15:0] r[7:0];
/*autodef*/
//Start of automatic define
//Start of automatic reg
//Define flip-flop registers here
//Define combination registers here
//End of automatic reg
//Start of automatic wire
//Define assign wires here
wire [2:0]                      dr_index                        ;
wire [2:0]                      sr1_index                       ;
wire [2:0]                      sr2_index                       ;
//Define instance wires here
//End of automatic wire
//End of automatic define

assign dr_index[2:0] = (dr_mux[1:0]==DRMUX_IR) ? ir_slice[11:9] : 
                       (dr_mux[1:0]==DRMUX_R6) ? 3'b110 :
                       3'b111;
assign sr1_index[2:0] = (sr1_mux[1:0]==SR1MUX_IR_H) ? ir_slice[11:9] :
                        (sr1_mux[1:0]==SR1MUX_IR_L) ? ir_slice[8:6] :
                        3'b110;
assign sr2_index[2:0] = ir_slice[2:0];

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
         r[0][15:0] <= #`RD 16'h0;
         r[1][15:0] <= #`RD 16'h0;
         r[2][15:0] <= #`RD 16'h0;
         r[3][15:0] <= #`RD 16'h0;
         r[4][15:0] <= #`RD 16'h0;
         r[5][15:0] <= #`RD 16'h0;
         r[6][15:0] <= #`RD 16'h0;
         r[7][15:0] <= #`RD 16'h0;
    end
    else if (ld_reg)begin
         r[dr_index[2:0]][15:0] <= #`RD bus[15:0];
    end
end

assign sr1_out[15:0] = r[sr1_index[2:0]];
assign sr2_out[15:0] = r[sr2_index[2:0]];

endmodule
//Instance .
