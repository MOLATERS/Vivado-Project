`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/01 22:43:20
// Design Name: 
// Module Name: mux_421
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


module mux_421_2(
    input [1:0] index, 
    input [4:0] data1,
    input [4:0] data2,
    input [4:0] data3,
    input [4:0] data4,
    output [4:0] result
    );
    assign result = (index == 2'b00) ? data1 : 
                    (index == 2'b01) ? data2 : 
                    (index == 2'b10) ? data3 : data4;
endmodule
