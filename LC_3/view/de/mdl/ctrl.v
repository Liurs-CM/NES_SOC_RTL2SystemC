// +FHDR----------------------------------------------------------------------------
// Project Name  : NES_SOC
// Device        : WSL2
// Author        : liurs
// Email         : liurs@njust.edu.cn
// Website       : liurs.cn
// Created On    : 2024/05/16 22:28
// Last Modified : 2024/05/28 23:43
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
// 2024/05/23   liurs           1.0                     Add 42 ctrl signal output
// 2024/05/28   liurs           1.1                     Fix ir state cond err
// -FHDR----------------------------------------------------------------------------

module ctrl(/*autoarg*/
    //Inputs
    clk, rst_n, reg_n, reg_z, 
    reg_p, acv, interrupt, 
    ready, ir, psr_15, 
    //Outputs
    ld_mar, ld_mdr, ld_ir, ld_reg, 
    ld_cc, ld_pc, ld_priv, 
    ld_priority, ld_saved_ssp, 
    ld_saved_usp, ld_acv, 
    ld_vector, gate_pc, 
    gate_mdr, gate_alu, 
    gate_marmux, gate_vector, 
    gate_pc_m1, gate_psr, 
    gate_sp, pcmux, drmux, 
    sr1mux, addr1mux, 
    addr2mux, spmux, marmux, 
    tablemux, vecmux, psrmux, 
    aluk, mio_en, r_w, 
    set_priv
);

input clk;
input rst_n;
//condition port
input reg_n;
input reg_z;
input reg_p;
input acv;
input interrupt;
input ready;
input [15:0] ir;
input psr_15;

//ctrl port
output ld_mar;
output ld_mdr;
output ld_ir;
output ld_reg;
output ld_cc;
output ld_pc;
output ld_priv;
output ld_priority;
output ld_saved_ssp;
output ld_saved_usp;
output ld_acv;
output ld_vector;
output gate_pc;
output gate_mdr;
output gate_alu;
output gate_marmux;
output gate_vector;
output gate_pc_m1;
output gate_psr;
output gate_sp;
output [1:0] pcmux;
output [1:0] drmux;
output [1:0] sr1mux;
output addr1mux;
output [1:0] addr2mux;
output [1:0] spmux;
output marmux;
output tablemux;
output [1:0] vecmux;
output psrmux;
output [1:0] aluk;
output mio_en;
output r_w;
output set_priv;

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
//Start of automatic define
//Start of automatic reg
//Define flip-flop registers here
reg  [5:0]                      cur_state                       ;
reg                             ben                             ;
//Define combination registers here
reg  [5:0]                      nxt_state                       ;
//End of automatic reg
//Start of automatic wire
//Define assign wires here
wire [5:0]                      st                              ;
wire                            ld_ben                          ; // WIRE_NEW
//Define instance wires here
//End of automatic wire
//End of automatic define

//control finite state machine
always@(*) begin
    case(cur_state)
        BR: begin
            if(ben)
                nxt_state <= #`RD BR_O_PC;
            else
                nxt_state <= #`RD FETCH;
        end
        ADD:    nxt_state <= #`RD FETCH;
        LD:     nxt_state <= #`RD LDX_ACV;
        ST:     nxt_state <= #`RD STX_ACV;
        JSR: begin
            if(ir[11])
                nxt_state <= #`RD JSR_O_PC;
            else
                nxt_state <= #`RD JSR_R_PC;
        end
        AND:    nxt_state <= #`RD FETCH;
        LDR:    nxt_state <= #`RD LDX_ACV;
        STR:    nxt_state <= #`RD STX_ACV;
        RTI: begin
            if(psr_15)
                nxt_state <= #`RD RTI_VEC0;
            else
                nxt_state <= #`RD RTI_MDR1;
        end
        NOT:    nxt_state <= #`RD FETCH;
        LDI:    nxt_state <= #`RD LDI_ACV;
        STI:    nxt_state <= #`RD STI_ACV;
        JMP:    nxt_state <= #`RD FETCH;
        RSV: begin
            if(psr_15)
                nxt_state <= #`RD S_SSP_USP;
            else
                nxt_state <= #`RD INT_MAR1;
        end
        LEA:    nxt_state <= #`RD FETCH;
        TRAP:   nxt_state[5:0] = TRAP_CHK;

        ST_MEM: begin
                if(ready)
                        nxt_state <= #`RD FETCH;
                else
                        nxt_state <= #`RD ST_MEM;
        end
        LDI_ACV: begin
                if(acv)
                        nxt_state <= #`RD ACV_2;
                else
                        nxt_state <= #`RD LDI_DEC;
        end
        FETCH: begin
                if(acv)
                        nxt_state <= #`RD INT_CHK;
                else
                        nxt_state <= #`RD FETCH_ACV;
        end
        STI_ACV: begin
                if(acv)
                        nxt_state <= #`RD ACV_5;
                else
                        nxt_state <= #`RD STI_DEC;
        end
        JSR_R_PC:       nxt_state <= #`RD FETCH;
        JSR_O_PC:       nxt_state <= #`RD FETCH;
        BR_O_PC:        nxt_state <= #`RD FETCH;
        STX_ACV: begin
                if(acv)
                        nxt_state <= #`RD ACV_1;
                else
                        nxt_state <= #`RD ST_MEM;
        end
        LDI_DEC: begin
                if(ready)
                        nxt_state <= #`RD LDI_MAR;
                else
                        nxt_state <= #`RD LDI_DEC;
        end
        LDX_DEC: begin
                if(ready)
                        nxt_state <= #`RD LDX_DR;
                else
                        nxt_state <= #`RD LDX_DEC;
        end
        LDI_MAR:        nxt_state <= #`RD LDX_ACV;
        LDX_DR: nxt_state <= #`RD FETCH;
        FETCH_MDR: begin
                if(ready)
                        nxt_state <= #`RD FETCH_IR;
                else
                        nxt_state <= #`RD FETCH_MDR;
        end
        STI_DEC: begin
                if(ready)
                        nxt_state <= #`RD STI_MAR2;
                else
                        nxt_state <= #`RD STI_DEC;
        end
        FETCH_IR:       nxt_state <= #`RD DECODE;
        STI_MAR2:       nxt_state <= #`RD STX_ACV;
        DECODE: nxt_state <= #`RD ir[15:12];
        FETCH_ACV: begin
                if(acv)
                        nxt_state <= #`RD ACV_4;
                else
                        nxt_state <= #`RD FETCH_MDR;
        end
        RTI_CHK2: begin
                if(psr_15)
                        nxt_state <= #`RD RTI_S_SP;
                else
                        nxt_state <= #`RD IDLE;
        end
        LDX_ACV: begin
                if(acv)
                        nxt_state <= #`RD ACV_3;
                else
                        nxt_state <= #`RD LDX_DEC;
        end
        RTI_MDR1: begin
                if(ready)
                        nxt_state <= #`RD RTI_PC;
                else
                        nxt_state <= #`RD RTI_MDR1;
        end
        INT_MAR1:       nxt_state <= #`RD INT_WR1;
        RTI_PC: nxt_state <= #`RD RTI_MAR2;
        RTI_MAR2:       nxt_state <= #`RD RTI_MDR2;
        RTI_MDR2: begin
                if(ready)
                        nxt_state <= #`RD RTI_PSR;
                else
                        nxt_state <= #`RD RTI_MDR2;
        end
        INT_WR1: begin
                if(ready)
                        nxt_state <= #`RD INT_MDR2;
                else
                        nxt_state <= #`RD INT_WR1;
        end
        RTI_PSR:        nxt_state <= #`RD RTI_CHK2;
        INT_MDR2:       nxt_state <= #`RD INT_MAR2;
        RTI_VEC0:       nxt_state <= #`RD S_SSP_USP;
        S_SSP_USP:      nxt_state <= #`RD INT_MAR1;
        INT_MAR2:       nxt_state <= #`RD INT_WR2;
        TRAP_CHK: begin
                if(psr_15)
                        nxt_state <= #`RD S_SSP_USP;
                else
                        nxt_state <= #`RD INT_MAR1;
        end
        ACV_1:  nxt_state <= #`RD S_SSP_USP;
        INT_CHK: begin
                if(psr_15)
                        nxt_state <= #`RD S_SSP_USP;
                else
                        nxt_state <= #`RD INT_MAR1;
        end
        NOP_1:  nxt_state <= #`RD IDLE;
        IDLE:   nxt_state <= #`RD FETCH;
        INT_WR2: begin
                if(ready)
                        nxt_state <= #`RD INT_MAR3;
                else
                        nxt_state <= #`RD INT_WR2;
        end
        INT_MDR3: begin
                if(ready)
                        nxt_state <= #`RD INT_PCL;
                else
                        nxt_state <= #`RD INT_MDR3;
        end
        INT_MAR3:       nxt_state <= #`RD INT_MDR3;
        INT_PCL:        nxt_state <= #`RD FETCH;
        ACV_2:  nxt_state <= #`RD S_SSP_USP;
        ACV_3:  nxt_state <= #`RD S_SSP_USP;
        NOP_2:  nxt_state <= #`RD IDLE;
        RTI_S_SP:       nxt_state <= #`RD FETCH;
        ACV_4:  nxt_state <= #`RD S_SSP_USP;
        ACV_5:  nxt_state <= #`RD S_SSP_USP;
        NOP_3:  nxt_state <= #`RD IDLE;
        NOP_4:  nxt_state <= #`RD IDLE;
    endcase
end

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
         cur_state[5:0] <= #`RD IDLE;
    end
    else begin
         cur_state[5:0] <= #`RD nxt_state[5:0];
    end
end

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
         ben <= #`RD 1'b0;
    end
    else if (ld_ben)begin
         ben <= #`RD (ir[11] & reg_n) | (ir[10] & reg_z) | (ir[9] & reg_p);
    end
end

assign st[5:0] = cur_state[5:0];
//data control
assign ld_mar = (st== LD |st== ST |st== LDR |st== STR |st== RTI |st== LDI |st== STI |st== FETCH |st== LDI_MAR |st== STI_MAR2 |st== INT_MAR1 |st== RTI_MAR2 |st== INT_MAR2 |st== INT_MAR3 );
assign ld_mdr = (st== RSV |st== TRAP |st== STX_ACV |st== LDI_DEC |st== LDX_DEC |st== FETCH_MDR |st== STI_DEC |st== RTI_MDR1 |st== RTI_MDR2 |st== INT_MDR2 |st== RTI_VEC0 |st== ACV_1 |st== INT_CHK |st== INT_MDR3 |st== ACV_2 |st== ACV_3 |st== ACV_4 |st== ACV_5 );
assign ld_ir = (st== FETCH_IR );
assign ld_ben = (st== DECODE );
assign ld_reg = (st== ADD |st== AND |st== NOT |st== LEA |st== JSR_R_PC |st== JSR_O_PC |st== LDX_DR |st== RTI_CHK2 |st== INT_MAR1 |st== RTI_MAR2 |st== S_SSP_USP |st== INT_MAR2 |st== RTI_S_SP );
assign ld_cc = (st== ADD |st== AND |st== NOT |st== LDX_DR |st== RTI_PSR );
assign ld_pc = (st== JMP |st== TRAP |st== FETCH |st== JSR_R_PC |st== JSR_O_PC |st== BR_O_PC |st== RTI_PC |st== INT_PCL );
assign ld_priv = (st== RSV |st== RTI_PSR |st== RTI_VEC0 |st== TRAP_CHK |st== ACV_1 |st== INT_CHK |st== ACV_2 |st== ACV_3 |st== ACV_4 |st== ACV_5 );
assign ld_priority = (st== RTI_PSR |st== INT_CHK );
assign ld_saved_ssp = (st== S_SSP_USP |st== RTI_S_SP );
assign ld_saved_usp = 1'b0;
assign ld_acv = (st== LD |st== ST |st== LDR |st== STR |st== LDI |st== STI |st== FETCH |st== STX_ACV |st== LDI_MAR |st== STI_MAR2 );
assign ld_vector = (st== RSV |st== RTI_VEC0 |st== TRAP_CHK |st== ACV_1 |st== INT_CHK |st== ACV_2 |st== ACV_3 |st== ACV_4 |st== ACV_5 );
assign gate_pc = (st== FETCH |st== JSR_R_PC |st== JSR_O_PC );
assign gate_mdr = (st== LDI_MAR |st== LDX_DR |st== FETCH_IR |st== STI_MAR2 |st== RTI_PC |st== RTI_PSR |st== INT_PCL );
assign gate_alu = (st== ADD |st== AND |st== NOT |st== JMP |st== STX_ACV );
assign gate_marmux = (st== LD |st== ST |st== LDR |st== STR |st== RTI |st== LDI |st== STI |st== LEA |st== TRAP_CHK );
assign gate_vector = (st== INT_MAR3 );
assign gate_pc_m1 = (st== INT_MDR2 );
assign gate_psr = (st== RSV |st== TRAP |st== RTI_VEC0 |st== ACV_1 |st== INT_CHK |st== ACV_2 |st== ACV_3 |st== ACV_4 |st== ACV_5 );
assign gate_sp = (st== RTI_CHK2 |st== INT_MAR1 |st== RTI_MAR2 |st== S_SSP_USP |st== INT_MAR2 |st== RTI_S_SP );
assign pcmux[0] = (st== JMP |st== RTI_PC |st== INT_PCL );
assign pcmux[1] = (st== JSR_R_PC |st== JSR_O_PC |st== BR_O_PC );
assign drmux[0] = (st== RTI_CHK2 |st== INT_MAR1 |st== RTI_MAR2 |st== S_SSP_USP |st== INT_MAR2 |st== RTI_S_SP );
assign drmux[1] = (st== JSR_R_PC |st== JSR_O_PC );
assign sr1mux[0] = (st== ADD |st== AND |st== LDR |st== STR |st== NOT |st== JMP |st== JSR_R_PC );
assign sr1mux[1] = (st== RTI |st== RTI_CHK2 |st== INT_MAR1 |st== RTI_MAR2 |st== S_SSP_USP |st== INT_MAR2 |st== RTI_S_SP );
assign addr1mux = (st== LD |st== ST |st== LDI |st== STI |st== LEA |st== JSR_O_PC |st== BR_O_PC );
assign addr2mux[0] = (st== LD |st== ST |st== RTI |st== LDI |st== STI |st== LEA |st== JSR_R_PC |st== BR_O_PC );
assign addr2mux[1] = (st== LDR |st== STR |st== RTI |st== JSR_R_PC );
assign spmux[0] = (st== RTI_CHK2 );
assign spmux[1] = (st== INT_MAR1 |st== RTI_MAR2 |st== INT_MAR2 );
assign marmux = (st== LD |st== ST |st== LDR |st== STR |st== RTI |st== LDI |st== STI |st== LEA );
assign tablemux = (st== RSV |st== RTI_VEC0 |st== ACV_1 |st== INT_CHK |st== ACV_2 |st== ACV_3 |st== ACV_4 |st== ACV_5 );
assign vecmux[0] = (st== INT_CHK );
assign vecmux[1] = (st== RSV |st== RTI_VEC0 |st== INT_CHK );
assign psrmux = (st== RTI_PSR );
assign aluk[0] = (st== AND |st== NOT |st== JMP |st== STX_ACV );
assign aluk[1] = (st== NOT |st== JMP |st== STX_ACV );
assign mio_en = (st== ST_MEM |st== LDI_DEC |st== LDX_DEC |st== FETCH_MDR |st== STI_DEC |st== RTI_MDR1 |st== RTI_MDR2 |st== INT_WR1 |st== INT_WR2 |st== INT_MDR3 );
assign r_w = (st== ST_MEM |st== INT_WR1 |st== INT_WR2 );
assign set_priv = 1'b0;

endmodule
//Instance .
