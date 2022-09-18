module Shift_Unit(

input    wire     [15:0]     A,B,
input    wire                clk,Shift_EN,
input    wire     [3:0]      ALU_FUN,
input    wire                RST,
output   reg      [15:0]     Shift_OUT,
output   reg                 Shift_Flag

);

reg [15:0] Shift_OUT_C;
reg        Shift_Flag_C;

always @(*)

begin

if(Shift_EN)

begin

case (ALU_FUN[1:0])

2'b00:

begin
Shift_OUT_C=(A>>1);
Shift_Flag_C=1'b1;
end

2'b01:

begin
Shift_OUT_C=(A<<1);
Shift_Flag_C=1'b1;
end

2'b10:

begin
Shift_OUT_C=(B>>1);
Shift_Flag_C=1'b1;
end

2'b11:

begin
Shift_OUT_C=(B<<1);
Shift_Flag_C=1'b1;
end

endcase

end

else
begin
Shift_OUT_C=16'b0;
Shift_Flag_C=1'b0;
end
end

always @(posedge clk or negedge RST)
begin

if(!RST)
begin
Shift_OUT<=16'b0;
Shift_Flag<=1'b0;
end
else
begin
Shift_OUT<=Shift_OUT_C;
Shift_Flag<=Shift_Flag_C;
end
end

endmodule