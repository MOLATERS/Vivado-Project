`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/01 14:13:12
// Design Name: 
// Module Name: PC
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


module PC(
    input wire Reset,
    input wire Clk,
    input wire PCwen,
    input wire [31:0] NPC,
    output wire [31:0] PC
);

reg [31:0] Register;

always @(posedge Clk or posedge Reset) begin//当出现了时钟信号或者重置信号或者PC信号的时候相应
    //当Reset信号为1的时候，将PC重置
    if (Reset) Register <= 32'h00000000;
    else if (PCwen) Register <= NPC;    
end

assign PC = Register;

endmodule
