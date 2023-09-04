`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/01 15:36:08
// Design Name: 
// Module Name: NPC
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


module NPC(
    input wire clk,    // 时钟输入
    input wire rst,    // 复位输入
    input wire [31:0] NPCin,
    input wire load,        //载入使能
    output wire [31:0] NPCout
    );
    reg [31:0] NPC_out;
  always @(*) begin
    if (rst) begin
      // 复位时，将寄存器清零
      NPC_out <= 32'h00000000;
    end else if (load) begin
      // 如果 load 信号为高，则将数据加载到寄存器
      NPC_out <= NPCin;
    end
    // 如果需要其他控制逻辑，请在此处添加
  end
    assign NPCout = NPC_out;
endmodule