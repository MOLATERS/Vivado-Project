`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/30 19:15:29
// Design Name: 
// Module Name: i_ram
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


module i_ram(
input clk,

input [7:0] ram_addr,

output [31:0] ram_rdata
    );
   
wire [7:0] addr_d;//·ÀÖ¹µØÖ·³ö´í

assign addr_d = ( ram_addr % 4 == 0 ) ? ram_addr >> 2 : 8'b0;

ramb i_ram (
    .clka (clk      ),
    .wea  (1'b0  ),
    .addra( addr_d  ),
    .dina (32'hffffffff ),
    .douta(ram_rdata ) 
);
endmodule
