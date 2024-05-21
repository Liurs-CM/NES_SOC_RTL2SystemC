// +FHDR----------------------------------------------------------------------------
// Project Name  : NES_SOC
// Device        : WSL2
// Author        : liurs
// Email         : liurs@njust.edu.cn
// Website       : liurs.cn
// Created On    : 2024/05/18 10:29
// Last Modified : 2024/05/18 10:54
// File Name     : data_matrix_alu.v
// Description   :
//         
// Copyright (c) 2024 OpenSource Co.,Ltd..
// ALL RIGHTS RESERVED
// 
// ---------------------------------------------------------------------------------
// Modification History:
// Date         By              Version                 Change Description
// ---------------------------------------------------------------------------------
// 2024/05/18   liurs           1.0                     Original
// -FHDR----------------------------------------------------------------------------

module data_matrix_alu(/*autoarg*/
    //Inputs
    aluk, gate_alu_en, ir_slice, 
    sr2, sr1, 
    //Outputs
    alu
);
input [1:0] aluk;
input gate_alu_en;
input [5:0] ir_slice;
input [15:0] sr2;
input [15:0] sr1;
output [15:0] alu;

/*autodef*/
//Start of automatic define
//Start of automatic reg
//Define flip-flop registers here
//Define combination registers here
//End of automatic reg
//Start of automatic wire
//Define assign wires here
wire [15:0]                     imm5_sext                       ;
wire [15:0]                     sr2_mux                         ;
wire [15:0]                     alu_mux                         ;
//Define instance wires here
//End of automatic wire
//End of automatic define

assign imm5_sext[15:0] = {11{ir_slice[4]}, ir_slice[4:0]};
assign sr2_mux[15:0] = ir_slice[5] ? imm5_sext[15:0] : sr2[15:0];

assign alu_mux[15:0] = (aluk[1:0]==2'b00) ? sr1[15:0] + sr2_mux[15:0] : //add
                       (aluk[1:0]==2'b01) ? sr1[15:0] & sr2_mux[15:0] : //and
                       (aluk[1:0]==2'b10) ? ~sr1[15:0] :                //not
                       sr1[15:0] ;                                      //passa

assign alu[15:0] = gate_alu_en ? alu_mux[15:0] : 16'hzzzz;

endmodule
//Instance .
