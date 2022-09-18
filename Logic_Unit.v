module Logic_Unit(

input    wire     [15:0]    A,B,
input    wire               clk,Logic_EN,
input    wire     [3:0]     ALU_FUN,
input    wire               RST,
output   reg     [15:0]     Logic_OUT,
output   reg                Logic_Flag

);

reg [15:0] Logic_OUT_C;
reg        Logic_Flag_C;

always @(*)

begin

if(Logic_EN)

begin

case (ALU_FUN[1:0])

2'b00:

begin
Logic_OUT_C=A&B;
Logic_Flag_C=1'b1;
end

2'b01:

begin
Logic_OUT_C=A|B;
Logic_Flag_C=1'b1;
end

2'b10:

begin
Logic_OUT_C=~(A&B);
Logic_Flag_C=1'b1;
end

2'b11:

begin
Logic_OUT_C=~(A|B);
Logic_Flag_C=1'b1;
end

endcase

end

else
begin
Logic_OUT_C=16'b0;
Logic_Flag_C=1'b0;
end
end


always @(posedge clk or negedge RST)
begin

if(!RST)
begin
Logic_OUT<=16'b0;
Logic_Flag<=1'b0;
end
else
begin
Logic_OUT<=Logic_OUT_C;
Logic_Flag<=Logic_Flag_C;
end
end
endmodule