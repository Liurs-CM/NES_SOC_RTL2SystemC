// +FHDR----------------------------------------------------------------------------
// Project Name  : NES_SOC
// Device        : WSL2
// Author        : liurs
// Email         : liurs@njust.edu.cn
// Website       : liurs.cn
// Created On    : 2024/05/17 23:36
// Last Modified : 2024/05/24 01:24
// File Name     : data_matrix_ir_load.v
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

module data_matrix_ir_load(/*autoarg*/
    //Inputs
    clk, rst_n, bus, ld_ir, 
    //Outputs
    ir
);
input clk;
input rst_n;
input [15:0] bus;
input ld_ir;
output [15:0] ir;

reg [15:0] ir;
/*autodef*/
//Start of automatic define
//Start of automatic reg
//Define flip-flop registers here
//Define combination registers here
//End of automatic reg
//Start of automatic wire
//Define assign wires here
//Define instance wires here
//End of automatic wire
//End of automatic define

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
         ir[15:0] <= #`RD 16'h0;
    end
    else if (ld_ir)begin
         ir[15:0] <= #`RD bus[15:0];
    end
end

//assign ir_slice[15:0] = ir[15:0];


endmodule
//Instance .
