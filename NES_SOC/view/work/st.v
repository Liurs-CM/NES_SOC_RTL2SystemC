BR: begin
	if(ben)
		nxt_state <= #`RD FETCH;
	else
		nxt_state <= #`RD BR_O_PC;
end
ADD:	nxt_state <= #`RD FETCH;
LD:	nxt_state <= #`RD LDX_ACV;
ST:	nxt_state <= #`RD STX_ACV;
JSR: begin
	if(ir11)
		nxt_state <= #`RD JSR_R_PC;
	else
		nxt_state <= #`RD JSR_O_PC;
end
AND:	nxt_state <= #`RD FETCH;
LDR:	nxt_state <= #`RD LDX_ACV;
STR:	nxt_state <= #`RD STX_ACV;
RTI: begin
	if(psr15)
		nxt_state <= #`RD RTI_MDR1;
	else
		nxt_state <= #`RD RTI_VEC0;
end
NOT:	nxt_state <= #`RD FETCH;
LDI:	nxt_state <= #`RD LDI_ACV;
STI:	nxt_state <= #`RD STI_ACV;
JMP:	nxt_state <= #`RD FETCH;
RSV: begin
	if(psr15)
		nxt_state <= #`RD INT_MAR1;
	else
		nxt_state <= #`RD S_SSP_USP;
end
LEA:	nxt_state <= #`RD FETCH;
TRAP:	nxt_state <= #`RD TRAP_CHK;
ST_MEM: begin
	if(ready)
		nxt_state <= #`RD ST_MEM;
	else
		nxt_state <= #`RD FETCH;
end
LDI_ACV: begin
	if(acv)
		nxt_state <= #`RD LDI_DEC;
	else
		nxt_state <= #`RD ACV_2;
end
FETCH: begin
	if(acv)
		nxt_state <= #`RD FETCH_ACV;
	else
		nxt_state <= #`RD INT_CHK;
end
STI_ACV: begin
	if(acv)
		nxt_state <= #`RD STI_DEC;
	else
		nxt_state <= #`RD ACV_5;
end
JSR_R_PC:	nxt_state <= #`RD FETCH;
JSR_O_PC:	nxt_state <= #`RD FETCH;
BR_O_PC:	nxt_state <= #`RD FETCH;
STX_ACV: begin
	if(acv)
		nxt_state <= #`RD ST_MEM;
	else
		nxt_state <= #`RD ACV_1;
end
LDI_DEC: begin
	if(ready)
		nxt_state <= #`RD LDI_DEC;
	else
		nxt_state <= #`RD LDI_MAR;
end
LDX_DEC: begin
	if(ready)
		nxt_state <= #`RD LDX_DEC;
	else
		nxt_state <= #`RD LDX_DR;
end
LDI_MAR:	nxt_state <= #`RD LDX_ACV;
LDX_DR:	nxt_state <= #`RD FETCH;
FETCH_MDR: begin
	if(ready)
		nxt_state <= #`RD FETCH_MDR;
	else
		nxt_state <= #`RD FETCH_IR;
end
STI_DEC: begin
	if(ready)
		nxt_state <= #`RD STI_DEC;
	else
		nxt_state <= #`RD STI_MAR2;
end
FETCH_IR:	nxt_state <= #`RD DECODE;
STI_MAR2:	nxt_state <= #`RD STX_ACV;
DECODE:	nxt_state <= #`RD ir[15:12];
FETCH_ACV: begin
	if(acv)
		nxt_state <= #`RD FETCH_MDR;
	else
		nxt_state <= #`RD ACV_4;
end
RTI_CHK2: begin
	if(psr15)
		nxt_state <= #`RD IDLE;
	else
		nxt_state <= #`RD RTI_S_SP;
end
LDX_ACV: begin
	if(acv)
		nxt_state <= #`RD LDX_DEC;
	else
		nxt_state <= #`RD ACV_3;
end
RTI_MDR1: begin
	if(ready)
		nxt_state <= #`RD RTI_MDR1;
	else
		nxt_state <= #`RD RTI_PC;
end
INT_MAR1:	nxt_state <= #`RD INT_WR1;
RTI_PC:	nxt_state <= #`RD RTI_MAR2;
RTI_MAR2:	nxt_state <= #`RD RTI_MDR2;
RTI_MDR2: begin
	if(ready)
		nxt_state <= #`RD RTI_MDR2;
	else
		nxt_state <= #`RD RTI_PSR;
end
INT_WR1: begin
	if(ready)
		nxt_state <= #`RD INT_WR1;
	else
		nxt_state <= #`RD INT_MDR2;
end
RTI_PSR:	nxt_state <= #`RD RTI_CHK2;
INT_MDR2:	nxt_state <= #`RD INT_MAR2;
RTI_VEC0:	nxt_state <= #`RD S_SSP_USP;
S_SSP_USP:	nxt_state <= #`RD INT_MAR1;
INT_MAR2:	nxt_state <= #`RD INT_WR2;
TRAP_CHK: begin
	if(psr15)
		nxt_state <= #`RD INT_MAR1;
	else
		nxt_state <= #`RD S_SSP_USP;
end
ACV_1:	nxt_state <= #`RD S_SSP_USP;
INT_CHK: begin
	if(psr15)
		nxt_state <= #`RD INT_MAR1;
	else
		nxt_state <= #`RD S_SSP_USP;
end
NOP_1:	nxt_state <= #`RD IDLE;
IDLE:	nxt_state <= #`RD FETCH;
INT_WR2: begin
	if(ready)
		nxt_state <= #`RD INT_WR2;
	else
		nxt_state <= #`RD INT_MAR3;
end
INT_MDR3: begin
	if(ready)
		nxt_state <= #`RD INT_MDR3;
	else
		nxt_state <= #`RD INT_PCL;
end
INT_MAR3:	nxt_state <= #`RD INT_MDR3;
INT_PCL:	nxt_state <= #`RD FETCH;
ACV_2:	nxt_state <= #`RD S_SSP_USP;
ACV_3:	nxt_state <= #`RD S_SSP_USP;
NOP_2:	nxt_state <= #`RD IDLE;
RTI_S_SP:	nxt_state <= #`RD FETCH;
ACV_4:	nxt_state <= #`RD S_SSP_USP;
ACV_5:	nxt_state <= #`RD S_SSP_USP;
NOP_3:	nxt_state <= #`RD IDLE;
NOP_4:	nxt_state <= #`RD IDLE;
