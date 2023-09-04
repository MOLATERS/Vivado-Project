`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/30 18:41:52
// Design Name: 
// Module Name: IR
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


module IR(//指令寄存器
input reset,
input [31:0] in_ins,

output [31:0] out_ins
    );
    
reg [31:0] instruction;//指令寄存器

always @ (*) begin
     if (!reset) begin//如果初始化那么全部设为0
         instruction <= 32'h0;
     end
     
     else begin
         instruction <= in_ins;
     end
end

assign out_ins = instruction;

endmodule
