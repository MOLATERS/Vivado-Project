`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/27 21:16:08
// Design Name: 
// Module Name: 2-1mux
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


module mux(
    input wire [1:0] d0,
    input wire [1:0] d1,
    input select,
    output [1:0] out
    );
    assign out = (select==1)?d1:d0;

endmodule
