`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/06 21:14:44
// Design Name: 
// Module Name: mux_pc
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


module mux_pc(
    input data1,
    input data2,
    input index,
    output npc
    );
    
    mux_221 mux_pc (
        .data1(data1),
        .data2(data2),
        .index(index),
        .result(npc)
    );

endmodule
