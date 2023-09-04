`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/03 15:35:57
// Design Name: 
// Module Name: B_MUX
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


module B_MUX(
    input [31:0] B_data1,
    input [31:0] B_data2,
    input [31:0] B_data3,
    input [31:0] B_data4,
    input [1:0] B_select,
    output wire [31:0] B_data_chosen
    );

MUX_4_1 B(
    .data1(B_data1),
    .data2(B_data2),
    .data3(B_data3),
    .data4(B_data4),
    .select(B_select),
    .data_chosen(B_data_chosen)
);

endmodule
