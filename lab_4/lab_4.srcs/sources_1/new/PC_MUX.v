`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/03 15:36:41
// Design Name: 
// Module Name: PC_MUX
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


module PC_MUX(
    input [31:0] data1,
    input [31:0] data2,
    input [31:0] data3,
    input [31:0] data4,
    input [1:0] select,
    output wire [31:0] data_chosen
    );
MUX_4_1 PC(
    .data1(data1),
    .data2(data2),
    .data3(data3),
    .data4(data4),
    .select(select),
    .data_chosen(data_chosen)
);

endmodule
