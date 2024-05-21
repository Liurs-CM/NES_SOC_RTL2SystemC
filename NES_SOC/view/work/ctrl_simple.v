// +FHDR----------------------------------------------------------------------------
// Project Name  : NES_SOC
// Device        : WSL2
// Author        : liurs
// Email         : liurs@njust.edu.cn
// Website       : liurs.cn
// Created On    : 2024/05/16 22:28
// Last Modified : 2024/05/19 14:55
// File Name     : ctrl.v
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

module ctrl(/*autoarg*/
    //Inputs
    jmp, condition, ird, int, r, 
    ir, ben, psr_15, acv, 
    //Outputs
    ctrl_sig
);
input [5:0] jmp;
input [2:0] condition;
input ird;
input n;
input z;
input p;
input int;
input ready;
input [15:0] ir;
input psr_15;
output [41:0] ctrl_sig;

//condition state
localparam UNCOND   = 3'd0;
localparam MEM_RDY  = 3'd1;
localparam BRANCH   = 3'd2;
localparam ADDR_MODE= 3'd3;
localparam PRI_MODE = 3'd4;
localparam INT_TEST = 3'd5;
localparam ACV_TEST = 3'd6;

//fsm state
localparam BR   = 6'd00;
localparam ADD  = 6'd01;
localparam LD   = 6'd02;
localparam ST   = 6'd03;
localparam JSR  = 6'd04;
localparam AND  = 6'd05;
localparam LDR  = 6'd06;
localparam STR  = 6'd07;
localparam RTI  = 6'd08;
localparam NOT  = 6'd09;
localparam LDI  = 6'd10;
localparam STI  = 6'd11;
localparam JMP  = 6'd12;
localparam RSV  = 6'd13;
localparam LEA  = 6'd14;
localparam TRAP = 6'd15;

localparam ST_MEM   = 6'd16;
localparam LDI_ACV  = 6'd17;
localparam FETCH    = 6'd18;
localparam STI_ACV  = 6'd19;
localparam JSR_R_PC = 6'd20;
localparam JSR_O_PC = 6'd21;
localparam BR_O_PC  = 6'd22;
localparam STX_ACV  = 6'd23;
localparam LDI_DEC  = 6'd24;
localparam LDX_DEC  = 6'd25;
localparam LDI_MAR  = 6'd26;
localparam LDX_DR   = 6'd27;
localparam FETCH_MDR= 6'd28;
localparam STI_DEC  = 6'd29;
localparam FETCH_IR = 6'd30;
localparam STI_MAR2 = 6'd31;
localparam DECODE   = 6'd32;
localparam FETCH_ACV= 6'd33;
localparam RTI_CHK2 = 6'd34;
localparam LDX_ACV  = 6'd35;
localparam RTI_MDR1 = 6'd36;
localparam INT_MAR1 = 6'd37;
localparam RTI_PC   = 6'd38;
localparam RTI_MAR2 = 6'd39;
localparam RTI_MDR2 = 6'd40;
localparam INT_WR1  = 6'd41;
localparam RTI_PSR  = 6'd42;
localparam INT_MDR2 = 6'd43;
localparam RTI_VEC0 = 6'd44;
localparam S_SSP_USP= 6'd45;
localparam INT_MAR2 = 6'd46;
localparam TRAP_CHK = 6'd47;
localparam ACV_1    = 6'd48;
localparam INT_CHK  = 6'd49;
localparam NOP_1    = 6'd50;
localparam IDLE     = 6'd51;
localparam INT_WR2  = 6'd52;
localparam INT_MDR3 = 6'd53;
localparam INT_MAR3 = 6'd54;
localparam INT_PCL  = 6'd55;
localparam ACV_2    = 6'd56;
localparam ACV_3    = 6'd57;
localparam NOP_2    = 6'd58;
localparam RTI_S_SP = 6'd59;
localparam ACV_4    = 6'd60;
localparam ACV_5    = 6'd61;
localparam NOP_3    = 6'd62;
localparam NOP_4    = 6'd63;

/*autodef*/

assign ben = (ir[11] & n) | (ir[10] & z) | (ir[9] & p);

//data control
assign ld_mar       =
assign ld_mdr       =
assign ld_ir        =
assign ld_ben       =
assign ld_reg       =
assign ld_cc        =
assign ld_pc        =
assign ld_priv      =
assign ld_priority  =
assign ld_saved_ssp =
assign ld_saved_usp =
assign ld_acv       =
assign ld_vector    =
assign gate_pc      =
assign gate_mdr     =
assign gate_alu     =
assign gate_marmux  =
assign gate_vector  =
assign gate_pc_m1   =
assign gate_psr     =
assign gate_sp      =
assign pcmux[1:0]   =
assign drmux[1:0]   =
assign sr1mux[1:0]  =
assign addr1mux     =
assign addr2mux[1:0]=
assign spmux[1:0]   =
assign marmux       =
assign tablemux     =
assign vecmux[1:0]  =
assign psrmux       =
assign aluk[1:0]    =
assign mio_en       =
assign r_w          =
assign set_priv     =

//condition jump
always@(*)begin
    case(st)
        1

assign condition = (st==JSR) ? 
    ADDR_MODE :
                   (st==ST_MEM      | st==LDI_DEC   | st==LDX_DEC   |
                    st==FETCH_MDR   | st==STI_DEC   | st==RTI_MDR1  |
                    st==RTI_MDR2    | st==INT_WR1   | st==INT_WR2   |
                    st==INT_MDR3) ? 
    MEM_RDY :
                   (st==BR) ? 
    BRANCH :
                   (st==RTI         | st==RSV       | st=RTI_CHK2   |
                    st==TRAP_CHK    | st==INT_CHK) ? 
    PRI_MODE :
                   (st==FETCH) ? 
    INT_TEST :
                   (st==LDI_ACV     | st==STI_ACV   | STX_ACV       |
                    st==FETCH_ACV   | st==LDX_ACV) ? 
    ACV_TEST :
    UNCOND;
                                    

always@(*)begin
    case(condition)
        ADDR_MODE:  nxt_st[0] = st[0] | ir[11];
        MEM_RDY:    nxt_st[1] = st[1] | ready;
        BRANCH:     nxt_st[2] = st[2] | ben;
        PRI_MODE:   nxt_st[3] = st[3] | psr_15;
        INT_TEST:   nxt_st[4] = st[4] | int;
        ACV_TEST:   nxt_st[5] = st[5] | acv;
    endcase
end

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
         st[5:0] <= #`RD 6'h0;
    end
    else begin
         st[5:0] <= #`RD nxt_st[5:0];
    end
end


endmodule
//Instance .
