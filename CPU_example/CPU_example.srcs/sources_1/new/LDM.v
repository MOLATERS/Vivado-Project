`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/31 20:38:11
// Design Name: 
// Module Name: LDM
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


module LDM(
input [31:0] in_data,

output [31:0] out_data
    );
    
    reg [31:0] data;

always @(*) begin
       data <= in_data;
end

assign out_data = data;

endmodule
