// +FHDR----------------------------------------------------------------------------
// Project Name  : NES_SOC
// Device        : WSL2
// Author        : liurs
// Email         : liurs@njust.edu.cn
// Website       : liurs.cn
// Created On    : 2024/05/16 22:46
// Last Modified : 2024/05/18 00:21
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
module data_matrix
(
    /*autoarg*/
    //Inputs
    ctrl_sig_40, data_in, 
    //Outputs
    data_out, addr, ir, ben, 
    psr_15, acv
);
input [39:0] ctrl_sig_40;
input [15:0] data_in;
output [15:0] data_out;
output [15:0] addr;
output [4:0] ir;
output ben;
output psr_15;
output acv;

data_matrix_pc_load
data_matrix_effective_address
data_matrix_ir_load
data_matrix_reg
data_matrix_nzp_load
data_matrix_alu


endmodule
//Instance .
