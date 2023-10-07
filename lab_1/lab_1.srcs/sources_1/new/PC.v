`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/30 22:40:35
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
    input clk,
    input stop,
    input [31:0] NPC,
    input resetn,
    output reg [31:0] PC
    );
    reg [31:0] PC_next;
    reg pause;

    initial begin
        pause <= 0;
        PC_next <= NPC;
    end

    always @(posedge clk or negedge resetn)begin
    if(!pause) begin
        PC_next <= NPC;
        if (!resetn) PC_next = 32'h00000000;
        PC <= PC_next;
    end
    end  


endmodule
