module Parity_Calc (

input   wire              Data_Valid,PAR_TYP,CLK,RST,busy,excep,
input   wire    [7:0]     P_DATA,

output  reg               par_bit

);

integer i;

reg [7:0] IN_DATA;

reg [2:0] ones_count;

always @(posedge CLK or negedge RST)
begin

if(!RST)

IN_DATA <= 8'b0;

else

begin

// Condition of accepting Input Data to the Prity Calculator Block.

if(Data_Valid && !busy || (Data_Valid && excep))
begin

IN_DATA <= P_DATA;

end

end

end

always @(*)
begin

for(i=0;i<8;i=i+1)
begin

//Counting the number of ones in the Input Data.

if(IN_DATA[i])
ones_count = ones_count+3'b1;

end

if(PAR_TYP) //Odd Parity
begin

if(ones_count[0]) //No. of ones is Odd
par_bit = 1'b0;

else
par_bit=1'b1;

end

else if(Data_Valid && !PAR_TYP) //Even Parity
begin

if(ones_count[0])
par_bit = 1'b1;

else
par_bit=1'b0;

end

else
par_bit=1'b0;

end

endmodule