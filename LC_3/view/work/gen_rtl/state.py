#!/bin/python
state = {
"BR": 0, "ADD": 1, "LD": 2, "ST": 3, "JSR": 4, "AND": 5, "LDR": 6, "STR": 7, "RTI": 8, "NOT": 9, "LDI": 10, "STI": 11, "JMP": 12, "RSV": 13, "LEA": 14, "TRAP": 15, "ST_MEM": 16, "LDI_ACV": 17, "FETCH": 18, "STI_ACV": 19, "JSR_R_PC": 20, "JSR_O_PC": 21, "BR_O_PC": 22, "STX_ACV": 23, "LDI_DEC": 24, "LDX_DEC": 25, "LDI_MAR": 26, "LDX_DR": 27, "FETCH_MDR": 28, "STI_DEC": 29, "FETCH_IR": 30, "STI_MAR2": 31, "DECODE": 32, "FETCH_ACV": 33, "RTI_CHK2": 34, "LDX_ACV": 35, "RTI_MDR1": 36, "INT_MAR1": 37, "RTI_PC": 38, "RTI_MAR2": 39, "RTI_MDR2": 40, "INT_WR1": 41, "RTI_PSR": 42, "INT_MDR2": 43, "RTI_VEC0": 44, "S_SSP_USP": 45, "INT_MAR2": 46, "TRAP_CHK": 47, "ACV_1": 48, "INT_CHK": 49, "NOP_1": 50, "IDLE": 51, "INT_WR2": 52, "INT_MDR3": 53, "INT_MAR3": 54, "INT_PCL": 55, "ACV_2": 56, "ACV_3": 57, "NOP_2": 58, "RTI_S_SP": 59, "ACV_4": 60, "ACV_5": 61, "NOP_3": 62, "NOP_4": 63, }

st_array=["BR", "ADD", "LD", "ST", "JSR", "AND", "LDR", "STR", "RTI", "NOT", "LDI", "STI", "JMP", "RSV", "LEA", "TRAP", "ST_MEM", "LDI_ACV", "FETCH", "STI_ACV", "JSR_R_PC", "JSR_O_PC", "BR_O_PC", "STX_ACV", "LDI_DEC", "LDX_DEC", "LDI_MAR", "LDX_DR", "FETCH_MDR", "STI_DEC", "FETCH_IR", "STI_MAR2", "DECODE", "FETCH_ACV", "RTI_CHK2", "LDX_ACV", "RTI_MDR1", "INT_MAR1", "RTI_PC", "RTI_MAR2", "RTI_MDR2", "INT_WR1", "RTI_PSR", "INT_MDR2", "RTI_VEC0", "S_SSP_USP", "INT_MAR2", "TRAP_CHK", "ACV_1", "INT_CHK", "NOP_1", "IDLE", "INT_WR2", "INT_MDR3", "INT_MAR3", "INT_PCL", "ACV_2", "ACV_3", "NOP_2", "RTI_S_SP", "ACV_4", "ACV_5", "NOP_3", "NOP_4"]

print(state["BR"])

print(st_array[10])

st=[
[18,"ben",22],
[18,"uncond",],
[35,"uncond",],
[23,"uncond",],
[20,"ir[11]",21],
[18,"uncond",],
[35,"uncond",],
[23,"uncond",],
[36,"psr_15",44],
[18,"uncond",],
[17,"uncond",],
[19,"uncond",],
[18,"uncond",],
[37,"psr_15",45],
[18,"uncond",],
[47,"uncond",],
[16,"ready",18],
[24,"acv",56],
[33,"acv",49],
[29,"acv",61],
[18,"uncond",],
[18,"uncond",],
[18,"uncond",],
[16,"acv",48],
[24,"ready",26],
[25,"ready",27],
[35,"uncond",],
[18,"uncond",],
[28,"ready",30],
[29,"ready",31],
[32,"uncond",],
[23,"uncond",],
["ir[15:12]","uncond",],
[28,"acv",60],
[51,"psr_15",59],
[25,"acv",57],
[36,"ready",38],
[41,"uncond",],
[39,"uncond",],
[40,"uncond",],
[40,"ready",42],
[41,"ready",43],
[34,"uncond",],
[46,"uncond",],
[45,"uncond",],
[37,"uncond",],
[52,"uncond",],
[37,"psr_15",45],
[45,"uncond",],
[37,"psr_15",45],
[51,"uncond",],
[18,"uncond",],
[52,"ready",54],
[53,"ready",55],
[53,"uncond",],
[18,"uncond",],
[45,"uncond",],
[45,"uncond",],
[51,"uncond",],
[18,"uncond",],
[45,"uncond",],
[45,"uncond",],
[51,"uncond",],
[51,"uncond",]
]

i=0
for one in st:
    if(one[0]!="ir[15:12]"):
        if(one[1]=="uncond"):
            print(st_array[i]+":\tnxt_state <= #`RD "+st_array[one[0]]+";")
        else:
            print(st_array[i]+": begin")
            print("\tif("+one[1]+")")
            print("\t\tnxt_state <= #`RD "+st_array[one[2]]+";")
            print("\telse")
            print("\t\tnxt_state <= #`RD "+st_array[one[0]]+";")
            print("end")
    else:
        print(st_array[i]+":\tnxt_state <= #`RD "+one[0]+";")
    i=i+1
        
