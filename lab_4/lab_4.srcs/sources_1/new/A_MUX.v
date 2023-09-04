`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/03 15:34:39
// Design Name: 
// Module Name: A_MUX
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


module A_MUX(
    input [31:0] A_data1,
    input [31:0] A_data2,
    input [31:0] A_data3,
    input [31:0] A_data4,
    input [1:0] A_select,
    output wire [31:0] A_data_chosen
    );

MUX_4_1 A(
    .data1(A_data1),
    .data2(A_data2),
    .data3(A_data3),
    .data4(A_data4),
    .select(A_select),
    .data_chosen(A_data_chosen)
);

endmodule
