`timescale 1ns / 1ps

module vending_mealy (input clk,reset,input [1:0] coin,output reg dispense,chg5);
parameter a=2'd0,b= 2'd1,c=2'd2,d=2'd3;
reg [1:0] ps, ns;
always @(*) begin
case (ps)
a:ns = (coin==2'b01)?b:(coin==2'b10)?c:a;
b:ns = (coin==2'b01)?c:(coin==2'b10)?d:b;
c:ns = (coin==2'b01)?d:(coin==2'b10)?a:c;
d:ns = (coin==2'b01)?a:(coin==2'b10)?a:d;
endcase
end
always @(posedge clk) begin
if (reset) begin ps <= a;
dispense<=0;
chg5<=0;
end
else begin  ps <= ns;
dispense <= (ps==d && coin == 2'b01) || (ps==d && coin == 2'b10) || (ps==c && coin == 2'b10); 
chg5 <= (ps==d && coin==2'b10);
end
end
endmodule
