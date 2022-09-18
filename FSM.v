/* 

Module:UART_TX.
Author: Muhammad Aboseada

*/

module FSM (

//Input Ports
input    wire    Data_Valid,Parity_EN,ser_done,CLK,RST,

//Output Ports
output   reg              ser_en,busy,excep,
output   reg    [1:0]     mux_sel

);

//Defining the States

localparam  [2:0]  IDLE=3'b0,
                   Start_Bit=3'b1,
				   Serial_Data=3'b10,
				   Parity_Bit=3'b11,
				   Stop_Bit=3'b100;
				   

// Current and Next State variables

reg  [2:0]  current_state,next_state;



//State Transition

always @(posedge CLK or negedge RST)
begin

if(!RST)
begin

current_state<=IDLE;

end

else
begin
current_state<=next_state;
end

end

// Next State and Output Logic 

always @(*)
begin

//Initial Values 
ser_en=1'b0;
mux_sel=2'b01;
busy=1'b0;
excep=1'b0;

case(current_state)

IDLE:
begin

ser_en=1'b0;
mux_sel=2'b01;
busy=1'b0;

if(Data_Valid)
begin

next_state=Start_Bit;

end

else
begin

next_state=IDLE;

end

end

Start_Bit:
begin

mux_sel=2'b00;
busy=1'b1;
ser_en=1'b1;

next_state=Serial_Data;

end

Serial_Data:
begin

mux_sel=2'b10;
busy=1'b1;
ser_en=1'b1;

if(ser_done && Parity_EN)
begin

next_state=Parity_Bit;

end

else if(ser_done && (!Parity_EN))
begin

next_state=Stop_Bit;

end

else
begin

next_state=Serial_Data;

end

end

Parity_Bit:
begin

mux_sel=2'b11;
busy=1'b1;
ser_en=1'b0;

next_state=Stop_Bit;

end

Stop_Bit:
begin

mux_sel=2'b01;
busy=1'b1;
ser_en=1'b0;

if(Data_Valid)
begin

next_state=Start_Bit;
excep=1'b1;

end
else
begin

next_state=IDLE;
excep=1'b0;

end
end

endcase

end

endmodule
