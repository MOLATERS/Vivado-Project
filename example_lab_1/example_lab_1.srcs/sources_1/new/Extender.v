`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/02 10:47:34
// Design Name: 
// Module Name: Extender
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


module Extender(
    input wire [15:0] Ime_in,
    output wire [31:0] Ime_out
    );

    assign Ime_out = (Ime_in[15])?{16'hffff,Ime_in[15:0]}:{16'h0,Ime_in[15:0]};
    
endmodule

