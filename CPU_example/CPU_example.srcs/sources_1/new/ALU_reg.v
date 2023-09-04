`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/31 20:10:53
// Design Name: 
// Module Name: ALU_reg
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


module ALU_reg(//各种端口的寄存器
input clk,
input [31:0] in_num,

output [31:0] out_num
    );
    
reg [31:0] num;

always @( posedge clk ) begin
       num <= in_num;
end

assign out_num = num;
endmodule
