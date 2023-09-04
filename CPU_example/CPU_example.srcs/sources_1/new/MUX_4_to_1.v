`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/31 21:30:07
// Design Name: 
// Module Name: MUX_4_to_1
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


module MUX_4_to_1(

input [31:0] data_0,
input [31:0] data_1,
input [31:0] data_2,
input [31:0] data_3,

input [1:0] select,

output [31:0]data
    );
    
    assign data = (select == 0) ? data_0 :
                  (select == 1) ? data_1 :
                  (select == 2) ? data_2 : data_3;

endmodule
