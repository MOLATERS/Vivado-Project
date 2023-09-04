`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/03 15:32:30
// Design Name: 
// Module Name: Imm
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


module Imm(
    input wire clk,    // 时钟输入
    input wire rst,    // 复位输入
    input wire [31:0] din, // 数据输入
    input wire load,   // 载入控制输入
    output wire [31:0] dout // 数据输出
    );

Data_container Imm(
    .clk(clk),
    .rst(rst),
    .din(din),
    .load(load),
    .dout(dout)
);

endmodule

