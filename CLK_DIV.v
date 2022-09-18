module CLK_DIV (

input   wire            i_ref_clk,i_rst_n,i_clk_en,
input   wire   [4:0]    i_div_ratio,
output  reg             o_div_clk

);

reg [4:0] count_even,count_odd;

//Even Clock Divider

assign toggle_Cond=(count_even==((i_div_ratio>>1)-1'b1))? 1'b1:1'b0;

reg o_div_clk_s_e;

always @(posedge i_ref_clk or negedge i_rst_n)
begin

if(!i_rst_n)
begin

count_even<=5'b0;
o_div_clk_s_e<=1'b0;

end

else if(! i_div_ratio[0])
begin

if(toggle_Cond )
begin

o_div_clk_s_e <= !o_div_clk_s_e;
count_even<=1'b0;

end

else
begin

count_even<=count_even+1'b1;

end

end

end

// Odd Clock Divider
wire L,H;
reg flag;

reg o_div_clk_s_o;

assign L=(i_div_ratio>>1);
assign H=L+1'b1;

always @(posedge i_ref_clk or negedge i_rst_n)
begin

if(!i_rst_n)
begin

o_div_clk_s_o<=1'b0;
count_odd<=5'b0;
flag<=1'b0;

end

else if(i_div_ratio[0])
begin

if((((count_odd==H)&&!flag) || ((count_odd==L)&&flag)))
begin

o_div_clk_s_o <= !o_div_clk_s_o;
flag <= !flag;
count_odd<=5'b0;

end

else
begin  

count_odd<=count_odd+1'b1;

end

end

end


always @(*)

begin

if(i_div_ratio && i_clk_en && (i_div_ratio != 1) && i_div_ratio[0])

o_div_clk=o_div_clk_s_o;

else if (i_div_ratio && i_clk_en && (i_div_ratio != 1) &&  ! i_div_ratio[0])

o_div_clk=o_div_clk_s_e;

else

o_div_clk=i_ref_clk;

end

endmodule