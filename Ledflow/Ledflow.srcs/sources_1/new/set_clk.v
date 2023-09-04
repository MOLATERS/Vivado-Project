`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/05 19:03:17
// Design Name: 
// Module Name: set_clk
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


module set_clk(
    input clk,
    output clk_o
    );
    reg [31:0] clock_limit=32'd2;
    reg [31:0] counter=32'd0;
    reg clock=0;
always@(posedge clk)
begin
if(clock_limit==counter)
begin
counter<=32'd000000000;
end    
else
begin
counter<=counter+32'd000000001;
end
end

always@(posedge clk)
begin
if(counter==0)
begin
clock=~clock;
end
end
assign clk_o=clock;
endmodule
