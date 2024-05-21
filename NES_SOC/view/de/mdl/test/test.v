// +FHDR----------------------------------------------------------------------------
// Project Name  : NES_SOC
// Device        : WSL2
// Author        : liurs
// Email         : liurs@njust.edu.cn
// Website       : liurs.cn
// Created On    : 2024/05/15 21:28
// Last Modified : 2024/05/17 21:19
// File Name     : test.v
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
module test
(
);


    //Instance: /home/liurs/verilog/work/NES_SOC_RTL2SystemC/NES_SOC/view/de/mdl/test/tt.v
tt u_tt(/*autoinst*/
        .sin                    (sin[2:0]                       ), //input[2:0]
        .sout                   (sout[2:0]                      )  //output[2:0]
    );

endmodule
//Instance .
