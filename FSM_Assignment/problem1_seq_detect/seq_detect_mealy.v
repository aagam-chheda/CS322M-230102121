module seq_detect_mealy(input clk,din,reset,output y);
parameter a=2'd0,b=2'd1,c=2'd2,d=2'd3;
reg [1:0] ps,ns;
always@(*) begin
case(ps)
a:ns = din?b:a;
b:ns = din?c:a;
c:ns = din?c:d;
d:ns = din?b:a;
endcase
end
always@(posedge clk) begin
if(reset) ps<=A;
else ps<=ns;
end
assign y = (ps==d)&din;
endmodule
