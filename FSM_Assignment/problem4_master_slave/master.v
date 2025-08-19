module master_fsm(input clk,rst,ack, output req,done,output [7:0] data);
reg [2:0] ps, ns;
reg [2:0] bytesSent;  
reg [7:0] dataReg;
parameter idle = 3'd0,assertReq = 3'd1,waitAckHigh= 3'd2,dropReq = 3'd3, waitAckLow = 3'd4,nextByte = 3'd5,doneST = 3'd6; 
always @(*) begin
case (ps)
idle:ns = assertReq;
assertReq:ns = waitAckHigh;
waitAckHigh:ns = (ack ? dropReq  : waitAckHigh);
dropReq:ns = waitAckLow;
waitAckLow:ns = (!ack ? nextByte : waitAckLow);
nextByte:ns = (bytesSent == 3'd4 ? doneST : assertReq);
doneST:ns = doneST;
default:ns = idle;
endcase
end
always @(posedge clk) begin
if (rst) begin
ps      <= idle;
bytesSent <= 3'd0;
dataReg   <= 8'hA0; 
end else begin
ps <= ns;
if (ps == waitAckLow && ack == 1'b0) begin
bytesSent <= bytesSent + 3'd1;
dataReg   <= dataReg + 8'h01; 
end
end
end
assign req  = (ps == assertReq) || (ps == waitAckHigh);
assign done = (ps == doneST);
assign data = dataReg;
endmodule
