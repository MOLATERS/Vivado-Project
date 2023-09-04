`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/16 19:57:22
// Design Name: 
// Module Name: dazuoye
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


module dazuoye(
output [7:0]ball,
input wire p1,
input wire p2,
input [7:0]div,
input reset,
input clk,  
output [7:0] display1,
output [3:0] place1,
output [7:0] display2,
output [3:0] place2,
output who,
output who1
);

wire [3:0]b1;
wire [3:0]b2;//发球的次数
wire [3:0]score1;
wire [3:0]score2;
wire [3:0]s1;
wire [3:0]s2;//两位选手的大比分

pingpang u1(ball,p1,p2,b1,b2,score1,score2,s1,s2,div,reset,clk,who,who1);

new_show u2(clk,score2,s2,4'b0001,4'b0010,4'b1000,display1,place1,reset);
new_show u3(clk,score1,s1,4'b0100,4'b1000,4'b0001,display2,place2,reset);


endmodule
