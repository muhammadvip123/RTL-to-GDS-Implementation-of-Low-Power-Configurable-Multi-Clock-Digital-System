module Serializer (

//Input Ports

input   wire    [7:0]    P_DATA,
input   wire             ser_en,CLK,RST,Data_Valid,busy,excep,

//Output Ports

output  reg    ser_data,ser_done

);

integer i;

reg [2:0] bits_count;
reg [7:0] IN_DATA;



always @(posedge CLK or negedge RST)
begin

if(!RST)
begin

ser_data <= 1'b0;
ser_done <= 1'b0;

end

// Condition of accepting Input Data to the Serializer

else if((Data_Valid && !busy) || (Data_Valid && excep))
begin

IN_DATA <= P_DATA;

end

// Condition of Driving data bit by bit into the output port of the Serializer

else if(ser_en)
begin

ser_data <= IN_DATA[bits_count];

end

else
begin

ser_data <= 1'b0;

end

end

// The Counter Logic ,counts 8 times (No. of data bits in each frame). 

always @(posedge CLK or negedge RST)
begin

if(!RST)
begin

bits_count <= 4'b0;
ser_done <= 1'b0;

end

else if(ser_en)
begin

bits_count <= bits_count+3'b1;

if(bits_count == 3'b111)
begin

ser_done <= 1'b1;

end

end

else

begin

bits_count <= 3'b0;
ser_done   <= 1'b0;

end

end

endmodule