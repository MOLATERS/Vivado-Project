`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/01 16:02:34
// Design Name: 
// Module Name: IR
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


module IR(
  input wire clk,    // 时钟输入
  input wire rst,    // 复位输入
  input wire [31:0] IRin, // 数据输入（32 位宽）
  input wire load,   // 载入控制输入
  output wire [31:0] IRout // 数据输出（32 位宽）
);

  // 声明寄存器变量
  reg [31:0] reg_data;

  always @(*) begin
    if (rst) begin
      // 复位时，将寄存器清零
      reg_data <= 4'h00000000;
    end else if (load) begin
      // 如果 load 信号为高，则将数据加载到寄存器
      reg_data <= IRin;
    end
    // 如果需要其他控制逻辑，请在此处添加
  end

  // 数据输出
  assign IRout = reg_data;

endmodule
