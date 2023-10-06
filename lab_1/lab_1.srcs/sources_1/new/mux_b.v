`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/06 21:14:44
// Design Name: 
// Module Name: mux_b
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

module mux_b(
    input [31:0] data1,
    input [31:0] data2,
    input [31:0] data3,
    input [31:0] data4,
    input [31:0] data5,
    input [31:0] data6,
    input [31:0] data7,
    input [31:0] data8,
    input [2:0] index,
    output [31:0] result_b
    );

    mux_821 mux_b(
        .data1(data1),
        .data2(data2),
        .data3(data3),
        .data4(data4),
        .data5(data5),
        .data6(data6),
        .data7(data7),
        .data8(data8),
        .index(index),
        .result(result_b)
    );

endmodule
