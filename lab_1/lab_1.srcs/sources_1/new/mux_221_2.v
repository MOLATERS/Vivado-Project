`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/07 19:25:51
// Design Name: 
// Module Name: mux_221_2
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


module mux_221_2(
    input index, 
    input [4:0] data1,
    input [4:0] data2,
    output [4:0] result
    );
    assign result = (index == 1'b0) ? data1 : data2;
endmodule
