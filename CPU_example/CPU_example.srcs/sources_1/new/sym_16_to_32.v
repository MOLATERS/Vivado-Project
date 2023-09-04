`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/31 20:16:08
// Design Name: 
// Module Name: sym_16_to_32
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


module sym_16_to_32(//·ûºÅÎ»À©Õ¹

input [15:0] in_num,

output [31:0] out_num
    );

assign out_num = ( in_num[15] ) ? {16'hffff, in_num} : {16'b0, in_num};

endmodule
