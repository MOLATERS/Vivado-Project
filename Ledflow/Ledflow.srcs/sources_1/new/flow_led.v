`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/04 23:22:10
// Design Name: 
// Module Name: flow_led
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module flow_led(
    input clk,
    input reset,
    output [7:0] led
    );
    reg [7:0] temp;
    reg [3:0] count=4'd0;
    reg [3:0] limit=4'd8;
    reg [7:0] led_o=8'b00000001;
always@(posedge clk ,posedge reset)
begin
if(reset||count==limit)begin
count=4'd0;end
else
begin
count=count+1;
end
end

always@(posedge clk,posedge reset)
begin
if(count==0||reset)
begin
temp<=8'b00000001;
led_o<=8'b00000001;
end
else
begin
temp<=led_o;
led_o<=led_o<<1;
end
end
assign led = temp;
endmodule
