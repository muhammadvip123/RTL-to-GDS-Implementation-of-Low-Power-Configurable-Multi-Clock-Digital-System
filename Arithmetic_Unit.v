module Arithmetic_Unit(

input    wire     [15:0]    A,B,
input    wire               clk,Arith_EN,
input    wire     [3:0]     ALU_FUN,
input    wire               RST,
output   reg     [15:0]     Arith_OUT,
output   reg                ALU_Carry,
output   reg                Arith_Flag

);

reg [15:0] Arith_OUT_C;
reg        ALU_Carry_C;
reg        Arith_Flag_C;

always @(*)

begin

if(Arith_EN)

begin

case (ALU_FUN[1:0])

2'b00:

begin
{ALU_Carry_C,Arith_OUT_C}=A+B;
Arith_Flag_C=1'b1;
end

2'b01:

begin
Arith_OUT_C=A-B;
Arith_Flag_C=1'b1;
ALU_Carry_C=1'b0;
end

2'b10:

begin
Arith_OUT_C=A*B;
Arith_Flag_C=1'b1;
ALU_Carry_C=1'b0;
end

2'b11:

begin
Arith_OUT_C=A/B;
Arith_Flag_C=1'b1;
ALU_Carry_C=1'b0;
end

endcase

end

else

begin
Arith_OUT_C=16'b0;
Arith_Flag_C=1'b0;
ALU_Carry_C=1'b0;
end

end



always @(posedge clk or negedge RST)
begin

if(!RST)
begin
Arith_OUT<=16'b0;
ALU_Carry<=1'b0;
Arith_Flag<=1'b0;
end
else
begin
Arith_OUT<=Arith_OUT_C;
ALU_Carry<=ALU_Carry_C;
Arith_Flag<=Arith_Flag_C;
end
end

endmodule



