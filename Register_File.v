module Register_File #
(parameter mem_width=16,
 parameter mem_Depth=8,
 parameter add_width=4)
(
input  wire  [mem_width-1:0]  WrData,
input  wire  [add_width-1:0]  Address,
input  wire                   Wr_En,Rd_EN,clk,rst,
output reg   [mem_width-1:0]  Rd_Data

);

reg [mem_width-1:0] Reg_File [mem_Depth-1:0];

always @(posedge clk or negedge rst)
begin

if(!rst)
begin

Reg_File[0]<=8'b0;
Reg_File[1]<=8'b0;
Reg_File[2]<=8'b0;
Reg_File[4]<=8'b0;
Reg_File[5]<=8'b0;
Reg_File[6]<=8'b0;
Reg_File[7]<=8'b0;

end

else if(Wr_En)
begin

Reg_File[Address]<=WrData;

end

else if(Rd_EN)
begin

Rd_Data<=Reg_File[Address];

end

end

endmodule
