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
    input wire [31:0] NPC,
    input wire reset,
    output wire [31:0] PC
    );
    reg [31:0] PC_next;
    always @(*) begin
        if (reset) 
            PC_next = 32'h00000000;
    end
    assign PC = PC_next;
endmodule