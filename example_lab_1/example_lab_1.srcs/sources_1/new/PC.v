`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/25 21:32:46
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
    input wire reset,
    input wire clk,
    input wire pc_we,
    input wire stop,
    input wire [31:0] NPC,
    output reg [31:0] PC
);

always @(posedge clk or negedge reset) begin
if (!stop)
begin    
    if (!reset) PC <= 32'h00000000;
    else PC <= NPC;       
end
end
endmodule
