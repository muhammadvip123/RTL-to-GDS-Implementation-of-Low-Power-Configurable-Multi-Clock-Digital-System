module Decoder(

input       wire    [3:0]     ALU_FUN,
output      reg              Arith_EN,Logic_EN,CMP_EN,Shift_EN
);

always @(*)
begin

case (ALU_FUN[3:2])

2'b00:

begin
Arith_EN=1'b1;
Logic_EN=1'b0;
CMP_EN=1'b0;
Shift_EN=1'b0;
end

2'b01:

begin
Arith_EN=1'b0;
Logic_EN=1'b1;
CMP_EN=1'b0;
Shift_EN=1'b0;
end

2'b10:

begin
Arith_EN=1'b0;
Logic_EN=1'b0;
CMP_EN=1'b1;
Shift_EN=1'b0;
end

2'b11:

begin
Arith_EN=1'b0;
Logic_EN=1'b0;
CMP_EN=1'b0;
Shift_EN=1'b1;
end

endcase

end

endmodule