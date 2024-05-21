// +FHDR----------------------------------------------------------------------------
// Project Name  : NES_SOC
// Device        : WSL2
// Author        : liurs
// Email         : liurs@njust.edu.cn
// Website       : liurs.cn
// Created On    : 2024/05/15 22:08
// Last Modified : 2024/05/17 21:07
// File Name     : tt.v
// Description   :
//         
// Copyright (c) 2024 OpenSource Co.,Ltd..
// ALL RIGHTS RESERVED
// 
// ---------------------------------------------------------------------------------
// Modification History:
// Date         By              Version                 Change Description
// ---------------------------------------------------------------------------------
// 2024/05/15   liurs           1.0                     Original
// -FHDR----------------------------------------------------------------------------

`timescale 1ns/1ps
module tt(
    /*autoarg*/
    //Inputs
    sin, 
    //Outputs
    sout
);
input [2:0] sin;
output [2:0] sout;

assign sout = ~sin;


endmodule
//Instance .
