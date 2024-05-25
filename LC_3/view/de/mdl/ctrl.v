// +FHDR----------------------------------------------------------------------------
// Project Name  : NES_SOC
// Device        : WSL2
// Author        : liurs
// Email         : liurs@njust.edu.cn
// Website       : liurs.cn
// Created On    : 2024/05/16 22:28
// Last Modified : 2024/05/26 02:35
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
                nxt_state[5:0] = BR_O_PC;
            else
                nxt_state[5:0] = FETCH;
        end
        ADD:    nxt_state[5:0] = FETCH;
        LD:     nxt_state[5:0] = LDX_ACV;
        ST:     nxt_state[5:0] = STX_ACV;
        JSR:    nxt_state[5:0] = STX_ACV;
        AND:    nxt_state[5:0] = FETCH;
        LDR:    nxt_state[5:0] = LDX_ACV;
        STR:    nxt_state[5:0] = STX_ACV;
        RTI: begin
            if(psr_15)
                nxt_state[5:0] = RTI_VEC0;
            else
                nxt_state[5:0] = RTI_MDR1;
        end
        NOT:    nxt_state[5:0] = FETCH;
        LDI:    nxt_state[5:0] = LDI_ACV;
        STI:    nxt_state[5:0] = STI_ACV;
        JMP:    nxt_state[5:0] = FETCH;
        RSV: begin
            if(psr_15)
                nxt_state[5:0] = S_SSP_USP;
            else
                nxt_state[5:0] = INT_MAR1;
        end
        LEA:    nxt_state[5:0] = FETCH;
        TRAP:   nxt_state[5:0] = TRAP_CHK;

        ST_MEM: begin
            if(ready)
                    nxt_state[5:0] = FETCH;
            else
                    nxt_state[5:0] = nxt_state;
        end
        LDI_ACV: begin
            if(acv)
                    nxt_state[5:0] = ACV_2;
            else
                    nxt_state[5:0] = LDI_DEC;
        end
        FETCH: begin
            if(interrupt)
                    nxt_state[5:0] = INT_CHK;
            else
                    nxt_state[5:0] = FETCH_ACV;
        end
        STI_ACV: begin
            if(acv)
                    nxt_state[5:0] = ACV_5;
            else
                    nxt_state[5:0] = STI_DEC;
        end
        JSR_R_PC:   nxt_state[5:0] = FETCH;
        JSR_O_PC:   nxt_state[5:0] = FETCH;
        BR_O_PC:    nxt_state[5:0] = FETCH;
        STX_ACV: begin
            if(acv)
                nxt_state[5:0] = ACV_1;
            else
                nxt_state[5:0] = ST_MEM;
        end
        LDI_DEC: begin
        	if(ready)
        		nxt_state[5:0] = LDI_DEC;
        	else
        		nxt_state[5:0] = LDI_MAR;
        end
        LDX_DEC: begin
        	if(ready)
        		nxt_state[5:0] = LDX_DEC;
        	else
        		nxt_state[5:0] = LDX_DR;
        end
        LDI_MAR:	nxt_state[5:0] = LDX_ACV;
        LDX_DR:	nxt_state[5:0] = FETCH;
        FETCH_MDR: begin
        	if(ready)
        		nxt_state[5:0] = FETCH_MDR;
        	else
        		nxt_state[5:0] = FETCH_IR;
        end
        STI_DEC: begin
        	if(ready)
        		nxt_state[5:0] = STI_DEC;
        	else
        		nxt_state[5:0] = STI_MAR2;
        end
        FETCH_IR:	nxt_state[5:0] = DECODE;
        STI_MAR2:	nxt_state[5:0] = STX_ACV;
        DECODE:	nxt_state[5:0] = ir[15:12];
        FETCH_ACV: begin
        	if(acv)
        		nxt_state[5:0] = FETCH_MDR;
        	else
        		nxt_state[5:0] = ACV_4;
        end
        RTI_CHK2: begin
        	if(psr_15)
        		nxt_state[5:0] = IDLE;
        	else
        		nxt_state[5:0] = RTI_S_SP;
        end
        LDX_ACV: begin
        	if(acv)
        		nxt_state[5:0] = LDX_DEC;
        	else
        		nxt_state[5:0] = ACV_3;
        end
        RTI_MDR1: begin
        	if(ready)
        		nxt_state[5:0] = RTI_MDR1;
        	else
        		nxt_state[5:0] = RTI_PC;
        end
        INT_MAR1:	nxt_state[5:0] = INT_WR1;
        RTI_PC:	nxt_state[5:0] = RTI_MAR2;
        RTI_MAR2:	nxt_state[5:0] = RTI_MDR2;
        RTI_MDR2: begin
        	if(ready)
        		nxt_state[5:0] = RTI_MDR2;
        	else
        		nxt_state[5:0] = RTI_PSR;
        end
        INT_WR1: begin
        	if(ready)
        		nxt_state[5:0] = INT_WR1;
        	else
        		nxt_state[5:0] = INT_MDR2;
        end
        RTI_PSR:	nxt_state[5:0] = RTI_CHK2;
        INT_MDR2:	nxt_state[5:0] = INT_MAR2;
        RTI_VEC0:	nxt_state[5:0] = S_SSP_USP;
        S_SSP_USP:	nxt_state[5:0] = INT_MAR1;
        INT_MAR2:	nxt_state[5:0] = INT_WR2;
        TRAP_CHK: begin
        	if(psr_15)
        		nxt_state[5:0] = INT_MAR1;
        	else
        		nxt_state[5:0] = S_SSP_USP;
        end
        ACV_1:	nxt_state[5:0] = S_SSP_USP;
        INT_CHK: begin
        	if(psr_15)
        		nxt_state[5:0] = INT_MAR1;
        	else
        		nxt_state[5:0] = S_SSP_USP;
        end
        NOP_1:	nxt_state[5:0] = IDLE;
        IDLE:	nxt_state[5:0] = FETCH;
        INT_WR2: begin
        	if(ready)
        		nxt_state[5:0] = INT_WR2;
        	else
        		nxt_state[5:0] = INT_MAR3;
        end
        INT_MDR3: begin
        	if(ready)
        		nxt_state[5:0] = INT_MDR3;
        	else
        		nxt_state[5:0] = INT_PCL;
        end
        INT_MAR3:	nxt_state[5:0] = INT_MDR3;
        INT_PCL:	nxt_state[5:0] = FETCH;
        ACV_2:	nxt_state[5:0] = S_SSP_USP;
        ACV_3:	nxt_state[5:0] = S_SSP_USP;
        NOP_2:	nxt_state[5:0] = IDLE;
        RTI_S_SP:	nxt_state[5:0] = FETCH;
        ACV_4:	nxt_state[5:0] = S_SSP_USP;
        ACV_5:	nxt_state[5:0] = S_SSP_USP;
        NOP_3:	nxt_state[5:0] = IDLE;
        NOP_4:	nxt_state[5:0] = IDLE;
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
assign r_w = (st== LD |st== ST |st== LDR |st== STR |st== RTI |st== LDI |st== STI |st== FETCH |st== LDI_MAR |st== STI_MAR2 |st== INT_MAR1 |st== RTI_MAR2 |st== INT_MAR2 |st== INT_MAR3 );
assign mio_en = (st== RSV |st== TRAP |st== STX_ACV |st== LDI_DEC |st== LDX_DEC |st== FETCH_MDR |st== STI_DEC |st== RTI_MDR1 |st== RTI_MDR2 |st== INT_MDR2 |st== RTI_VEC0 |st== ACV_1 |st== INT_CHK |st== INT_MDR3 |st== ACV_2 |st== ACV_3 |st== ACV_4 |st== ACV_5 );
assign aluk[1] = (st== FETCH_IR );
assign aluk[0] = (st== DECODE );
assign psrmux = (st== ADD |st== AND |st== NOT |st== LEA |st== JSR_R_PC |st== JSR_O_PC |st== LDX_DR |st== RTI_CHK2 |st== INT_MAR1 |st== RTI_MAR2 |st== S_SSP_USP |st== INT_MAR2 |st== RTI_S_SP );
assign vecmux[1] = (st== ADD |st== AND |st== NOT |st== LDX_DR |st== RTI_PSR );
assign vecmux[0] = (st== JMP |st== TRAP |st== FETCH |st== JSR_R_PC |st== JSR_O_PC |st== BR_O_PC |st== RTI_PC |st== INT_PCL );
assign tablemux = (st== RSV |st== RTI_PSR |st== RTI_VEC0 |st== TRAP_CHK |st== ACV_1 |st== INT_CHK |st== ACV_2 |st== ACV_3 |st== ACV_4 |st== ACV_5 );
assign marmux = (st== RTI_PSR |st== INT_CHK );
assign spmux[1] = (st== S_SSP_USP |st== RTI_S_SP );
assign spmux[0] = 1'b0;
assign addr2mux[1] = (st== LD |st== ST |st== LDR |st== STR |st== LDI |st== STI |st== FETCH |st== STX_ACV |st== LDI_MAR |st== STI_MAR2 );
assign addr2mux[0] = (st== RSV |st== RTI_VEC0 |st== TRAP_CHK |st== ACV_1 |st== INT_CHK |st== ACV_2 |st== ACV_3 |st== ACV_4 |st== ACV_5 );
assign addr1mux = (st== FETCH |st== JSR_R_PC |st== JSR_O_PC );
assign sr1mux[1] = (st== LDI_MAR |st== LDX_DR |st== FETCH_IR |st== STI_MAR2 |st== RTI_PC |st== RTI_PSR |st== INT_PCL );
assign sr1mux[0] = (st== ADD |st== AND |st== NOT |st== JMP |st== STX_ACV );
assign drmux[1] = (st== LD |st== ST |st== LDR |st== STR |st== RTI |st== LDI |st== STI |st== LEA |st== TRAP_CHK );
assign drmux[0] = (st== INT_MAR3 );
assign pcmux[1] = (st== INT_MDR2 );
assign pcmux[0] = (st== RSV |st== TRAP |st== RTI_VEC0 |st== ACV_1 |st== INT_CHK |st== ACV_2 |st== ACV_3 |st== ACV_4 |st== ACV_5 );
assign gate_sp = (st== RTI_CHK2 |st== INT_MAR1 |st== RTI_MAR2 |st== S_SSP_USP |st== INT_MAR2 |st== RTI_S_SP );
assign gate_psr = (st== JMP |st== RTI_PC |st== INT_PCL );
assign gate_pc_m1 = (st== JSR_R_PC |st== JSR_O_PC |st== BR_O_PC );
assign gate_vector = (st== RTI_CHK2 |st== INT_MAR1 |st== RTI_MAR2 |st== S_SSP_USP |st== INT_MAR2 |st== RTI_S_SP );
assign gate_marmux = (st== JSR_R_PC |st== JSR_O_PC );
assign gate_alu = (st== ADD |st== AND |st== LDR |st== STR |st== NOT |st== JMP |st== JSR_R_PC );
assign gate_mdr = (st== RTI |st== RTI_CHK2 |st== INT_MAR1 |st== RTI_MAR2 |st== S_SSP_USP |st== INT_MAR2 |st== RTI_S_SP );
assign gate_pc = (st== LD |st== ST |st== LDI |st== STI |st== LEA |st== JSR_O_PC |st== BR_O_PC );
assign ld_vector = (st== LD |st== ST |st== RTI |st== LDI |st== STI |st== LEA |st== JSR_R_PC |st== BR_O_PC );
assign ld_acv = (st== LDR |st== STR |st== RTI |st== JSR_R_PC );
assign ld_saved_usp = (st== RTI_CHK2 );
assign ld_saved_ssp = (st== INT_MAR1 |st== RTI_MAR2 |st== INT_MAR2 );
assign ld_priority = (st== LD |st== ST |st== LDR |st== STR |st== RTI |st== LDI |st== STI |st== LEA );
assign ld_priv = (st== RSV |st== RTI_VEC0 |st== ACV_1 |st== INT_CHK |st== ACV_2 |st== ACV_3 |st== ACV_4 |st== ACV_5 );
assign ld_pc = (st== INT_CHK );
assign ld_cc = (st== RSV |st== RTI_VEC0 |st== INT_CHK );
assign ld_reg = (st== RTI_PSR );
assign ld_ben = (st== AND |st== NOT |st== JMP |st== STX_ACV );
assign ld_ir = (st== NOT |st== JMP |st== STX_ACV );
assign ld_mdr = (st== ST_MEM |st== LDI_DEC |st== LDX_DEC |st== FETCH_MDR |st== STI_DEC |st== RTI_MDR1 |st== RTI_MDR2 |st== INT_WR1 |st== INT_WR2 |st== INT_MDR3 );
assign ld_mar = (st== ST_MEM |st== INT_WR1 |st== INT_WR2 );
assign set_priv = 1'b0;

endmodule
//Instance .
