module MUX (

//Input Ports

input   wire   [1:0]    mux_sel,
input   wire            start_bit,stop_bit,ser_data,par_data,

//Output Ports

output  reg   TX_OUT

);



always@(*)
begin

case(mux_sel)

2'b00: TX_OUT = start_bit;
2'b01: TX_OUT = stop_bit;
2'b10: TX_OUT = ser_data;
2'b11: TX_OUT = par_data;

endcase

end

endmodule