// +FHDR----------------------------------------------------------------------------
// Project Name  : NES_SOC
// Device        : WSL2
// Author        : liurs
// Email         : liurs@njust.edu.cn
// Website       : liurs.cn
// Created On    : 2024/05/26 01:50
// Last Modified : 2024/05/26 03:31
// File Name     : lc3_top_tb.sv
// Description   :
//         
// Copyright (c) 2024 OpenSource Co.,Ltd..
// ALL RIGHTS RESERVED
// 
// ---------------------------------------------------------------------------------
// Modification History:
// Date         By              Version                 Change Description
// ---------------------------------------------------------------------------------
// 2024/05/26   liurs           1.0                     Original
// -FHDR----------------------------------------------------------------------------

module lc3_tb_top;
    reg clk;
    reg rst_n;
    reg [15:0]                     pad_kbdr                        ;
    reg [15:0]                     pad_in_dsr                      ;
    reg [15:0]                     pad_kbsr                        ;
    reg [15:0]                     pad_ddr                         ;
    reg [15:0]                     pad_out_dsr                     ;

    /*autodef*/

    //Instance: /home/liurs/verilog/work/NES_SOC_RTL2SystemC/LC_3/view/de/top/lc3_top.v
    lc3_top DUT(/*autoinst*/
        .clk                    (clk                            ), //input
        .rst_n                  (rst_n                          ), //input
        .pad_kbdr               (pad_kbdr[15:0]                 ), //input[15:0]
        .pad_in_dsr             (pad_in_dsr[15:0]               ), //input[15:0]
        .pad_kbsr               (pad_kbsr[15:0]                 ), //output[15:0]
        .pad_ddr                (pad_ddr[15:0]                  ), //output[15:0]
        .pad_out_dsr            (pad_out_dsr[15:0]              )  //output[15:0]
    );

    always #5 clk = ~clk;

    initial begin
        $fsdbDumpfile("tb_top.fsdb");
        $fsdbDumpvars(0, lc3_tb_top);
        clk         =  0;
        rst_n       =  0;
        pad_kbdr    =  16'h0;
        pad_in_dsr  =  16'h0;
        //pad_kbsr    =  16'h0;
        //pad_ddr     =  16'h0;
        //pad_out_dsr =  16'h0;
        #10 rst_n   =  1;
        #1000
        $finish();
    end
endmodule
