`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/06 22:59:09
// Design Name: 
// Module Name: IF_ID
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


module IF_ID(
        input clk,
        input resetn,
        input [31:0] IF_npc,
        input [31:0] IF_ir,
        output [31:0] ID_npc,
        output [31:0] ID_ir
    );

    Container NPC(
        .resetn(resetn),
        .in(IF_npc),
        .out(ID_npc),
        .clk(clk)
    );

    Container IF_ID_IR(
        .resetn(resetn),
        .in(IF_ir),
        .out(ID_ir),
        .clk(clk)
    );

    

endmodule
