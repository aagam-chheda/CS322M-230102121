`timescale 1ms / 1us

module testbench2();
reg clk,rst,tick;
wire ns_g, ns_y, ns_r, ew_g, ew_y, ew_r;
traffic_light dut(.clk(clk),.rst(rst),.tick(tick),.ns_g(ns_g), .ns_y(ns_y), .ns_r(ns_r), .ew_g(ew_g), .ew_y(ew_y), .ew_r(ew_r));
initial clk =0;
always #5 clk = ~clk;
reg [6:0]count;
always @(posedge clk) begin
if (rst) begin
count <= 0;
tick <= 0;
end else begin
if (count == 99) begin
tick <= 1;
count <= 0;
end else begin
tick <= 0;
count <= count + 1;
end
end
end
initial begin
rst = 1; #20;
rst = 0; #50000;  
$finish;
end
initial begin
$dumpfile("wave.vcd");
$dumpvars(1, testbench2);
end
endmodule