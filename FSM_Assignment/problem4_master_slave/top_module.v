`timescale 1ns / 1ps

module link_top(input clk,rst,output done);
wire req, ack;
wire [7:0] data,last_byte;
master mas(.clk(clk),.rst(rst),.ack(ack),.req(req),.data(data),.done(done));
slave_fsm sla(.clk(clk),.rst(rst),.req(req), .data_in(data),.ack(ack),.last_byte(last_byte));
endmodule