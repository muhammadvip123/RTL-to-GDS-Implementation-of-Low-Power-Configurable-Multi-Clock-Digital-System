module CMP_Unit(

input    wire     [15:0]     A,B,
input    wire                clk,CMP_EN,
input    wire     [3:0]      ALU_FUN,
input    wire                RST,
output   reg     [15:0]      CMP_OUT,
output   reg                 CMP_Flag

);

reg [15:0] CMP_OUT_C;
reg        CMP_Flag_C;

always @(*)

begin

if(CMP_EN)

begin

case (ALU_FUN[1:0])

2'b00:

begin
CMP_OUT_C=16'b0;
CMP_Flag_C=1'b1;
end

2'b01:

begin
CMP_OUT_C=(A==B)?16'b1:16'b0;
CMP_Flag_C=1'b1;
end

2'b10:

begin
CMP_OUT_C=(A>B)?16'b1:16'b0;
CMP_Flag_C=1'b1;
end

2'b11:

begin
CMP_OUT_C=(A<B)?16'b1:16'b0;
CMP_Flag_C=1'b1;
end

endcase

end

else
begin
CMP_OUT_C=16'b0;
CMP_Flag_C=1'b0;
end

end


always @(posedge clk or negedge RST)
begin

if(!RST)
begin
CMP_OUT<=16'b0;
CMP_Flag<=1'b0;
end
else
begin
CMP_OUT<=CMP_OUT_C;
CMP_Flag<=CMP_Flag_C;
end
end
endmodule