module ALU_TOP(

input    wire     [15:0]     A,B,
input    wire     [3:0]      ALU_FUN,
input    wire                clk,
input    wire                RST,
output   wire      [15:0]    Arith_OUT,Logic_OUT,CMP_OUT,Shift_OUT,
output   wire                Carry_OUT,
output   wire                Arith_Flag,Logic_Flag,CMP_Flag,Shift_Flag                
);

wire Arith_EN,Logic_EN,CMP_EN,Shift_EN;

Arithmetic_Unit U_Arith(

.A(A),
.B(B),
.RST(RST),
.clk(clk),
.Arith_EN(Arith_EN),
.ALU_FUN(ALU_FUN),
.Arith_OUT(Arith_OUT),
.ALU_Carry(Carry_OUT),
.Arith_Flag(Arith_Flag)

);

Logic_Unit U_logic(

.A(A),
.B(B),
.RST(RST),
.clk(clk),
.Logic_EN(Logic_EN),
.ALU_FUN(ALU_FUN),
.Logic_OUT(Logic_OUT),
.Logic_Flag(Logic_Flag)

);

CMP_Unit U_CMP(

.A(A),
.B(B),
.RST(RST),
.clk(clk),
.CMP_EN(CMP_EN),
.ALU_FUN(ALU_FUN),
.CMP_OUT(CMP_OUT),
.CMP_Flag(CMP_Flag)

);

Shift_Unit U_Shift(

.A(A),
.B(B),
.RST(RST),
.clk(clk),
.Shift_EN(Shift_EN),
.ALU_FUN(ALU_FUN),
.Shift_OUT(Shift_OUT),
.Shift_Flag(Shift_Flag)

);

Decoder U_Decoder(

.ALU_FUN(ALU_FUN),
.Arith_EN(Arith_EN),
.Shift_EN(Shift_EN),
.CMP_EN(CMP_EN),
.Logic_EN(Logic_EN)

);

endmodule