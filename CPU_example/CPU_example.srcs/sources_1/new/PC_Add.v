`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/30 18:04:31
// Design Name: 
// Module Name: PC_Add
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


module PC_Add(//程序计数器自加法器
input  [31:0] in_address,

output [31:0] out_address
    );
    
    assign out_address = in_address + 4;//如果没有什么特别说明，那么PC自动加4
    
endmodule
