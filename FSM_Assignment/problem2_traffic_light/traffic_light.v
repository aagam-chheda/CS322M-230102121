`timescale 1ms / 1us

module traffic_light(input clk,rst,tick,output ns_g, ns_y, ns_r, ew_g, ew_y, ew_r);
parameter ns_g_=2'd0, ns_y_=2'd1, ew_g_=2'd2, ew_y_=2'd3;
reg [1:0] ps,ns;
reg [2:0] count_tick;
always@(*) begin
case(ps)
ns_g_: ns = ns_y_;
ns_y_: ns = ew_g_;
ew_g_: ns = ew_y_;
ew_y_: ns = ns_g_;
endcase
end
always @(posedge clk) begin
if (rst) begin
ps <= ns_g_;
count_tick <= 0;
end 
else if (tick) begin  
if ((ps == ns_g_  && count_tick == 3'd4) || (ps == ns_y_ && count_tick == 3'd1) ||(ps == ew_g_  && count_tick == 3'd4) ||(ps == ew_y_ && count_tick == 3'd1))
begin
ps <= ns;
count_tick <= 0;
end else begin
count_tick <= count_tick + 1;
end
end
end
assign ns_g = ps == ns_g_;
assign ns_y = ps == ns_y_;
assign ns_r = ps == ew_g_;
assign ew_g = ps == ew_g_;
assign ew_y = ps == ew_y_;
assign ew_r = ps == ns_g_;
endmodule
