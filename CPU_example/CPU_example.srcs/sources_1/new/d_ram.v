`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/30 19:15:44
// Design Name: 
// Module Name: d_ram
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


module d_ram(
input clk,
input ram_wen,
input [7:0] ram_addr,
input [31:0] ram_wdata,

output [31:0] ram_rdata
    );
 
wire [7:0] addr_d;//·ÀÖ¹µØÖ·³ö´í

assign addr_d = ( ram_addr % 4 == 0 ) ? ram_addr >> 2 : 8'b0;

ramd d_ram (
    .clka (clk       ),
    .wea  ( ram_wen   ),
    .addra( addr_d  ),
    .dina (ram_wdata ),
    .douta(ram_rdata ) 
);
endmodule
