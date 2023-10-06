`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/06 21:14:42
// Design Name: 
// Module Name: mux_wb
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



module mux_wb(
    input [1:0] index, 
    input [31:0] data1,
    input [31:0] data2,
    input [31:0] data3,
    input [31:0] data4,
    output [31:0] wbdata //写回数据
    );
    assign wbdata = (index == 2'b00) ? data1 : 
                    (index == 2'b01) ? data2 : 
                    (index == 2'b10) ? data3 : data4;
endmodule
