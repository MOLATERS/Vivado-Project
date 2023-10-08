`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/02 20:12:25
// Design Name: 
// Module Name: data_selecter_2_to_1
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


`timescale 1ns / 1ps
module data_selecter_2_to_1(
    input [31:0] data1,
    input [31:0] data2,
    input select,
    output wire [31:0] data_chosen
    );

    assign data_chosen = (select == 1'b0)? data1:data2;
endmodule
