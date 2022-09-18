/*

Description: Top Module of the UART_TX Block , that contains :

.Finite State Machine
.Serializer
.Parity Calculator 
.Multiplexer 

*/

module TOP_Module (

input   wire                CLK,RST,DATA_VALID,PAR_EN,PAR_TYP,
input   wire     [7:0]      P_DATA,

output  wire                TX_OUT,Busy

);

wire  [1:0]  mux_sel;
wire         ser_en,ser_done,ser_data,par_data,excep;


FSM UFSM (

.Data_Valid(DATA_VALID),
.Parity_EN(PAR_EN),
.ser_done(ser_done),
.CLK(CLK),
.RST(RST),
.ser_en(ser_en),
.busy(Busy),
.mux_sel(mux_sel),
.excep(excep)

);

Serializer USER(

.P_DATA(P_DATA),
.ser_en(ser_en),
.CLK(CLK),
.RST(RST),
.Data_Valid(DATA_VALID),
.ser_data(ser_data),
.ser_done(ser_done),
.busy(Busy),
.excep(excep)

);

MUX UMUX (

.mux_sel(mux_sel),
.start_bit(1'b0),
.stop_bit(1'b1),
.ser_data(ser_data),
.par_data(par_data),
.TX_OUT(TX_OUT)

);

Parity_Calc UPC (

.Data_Valid(DATA_VALID),
.PAR_TYP(PAR_TYP),
.P_DATA(P_DATA),
.par_bit(par_data),
.busy(Busy),
.excep(excep)

);

endmodule