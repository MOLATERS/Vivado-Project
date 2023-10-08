`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/02 12:29:27
// Design Name: 
// Module Name: data_selecter_4_to_1
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
module data_selecter_4_to_1(
    input [31:0] data1,
    input [31:0] data2,
    input [31:0] data3,
    input [31:0] data4,
    input [1:0] select,
    output wire [31:0] data_chosen
    );

    assign data_chosen = (select == 2'b00)? data1:
                         (select == 2'b01)? data2:
                         (select == 2'b10)? data3:
                         data4;
endmodule
