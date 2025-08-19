module slave_fsm(input  clk,rst,req,input [7:0] data_in,output ack,output reg [7:0] last_byte);
parameter waitReq = 2'd0,ackAssert = 2'd1,ackHold = 2'd2,waitDrop = 2'd3;
reg [1:0] ps, ns;
reg [1:0] holdCount;
always @(*) begin
case (ps)
waitReq:ns = req ? ackAssert : waitReq;
ackAssert:ns = ackHold;
ackHold:ns = (holdCount == 2'd1 ? waitDrop : ackHold);
waitDrop:ns = req ? waitDrop : waitReq;
default:ns = waitReq;
endcase
end
always @(posedge clk) begin
if (rst) begin
ps     <= waitReq;
holdCount  <= 2'd0;
last_byte <= 8'd0;
end 
else begin
ps <= ns;
if (ps == ackAssert) begin
last_byte <= data_in;  
holdCount  <= 2'd0;
end 
else if (ps == ackHold) begin
holdCount <= holdCount + 2'd1;
end 
else if (ps == waitReq) begin
holdCount <= 2'd0;
end
end
end
assign ack = (ps == ackAssert) || (ps == ackHold) || (ps == waitDrop);
endmodule