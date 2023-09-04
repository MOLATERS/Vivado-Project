`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/30 18:04:10
// Design Name: 
// Module Name: PC
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


module PC(//程序计数器

input clk,
input reset,
input  [31:0] in_address,

output [31:0] out_address

    );
    
reg [31:0] address;
initial begin
     address <= 32'b0;
end

always @ ( posedge clk ) begin
if (!reset) begin
           address <= 32'b0;//如果初始化那么就设置为全0
end

else begin
           address <= in_address;//如果没有初始化，那么就更新成为输入的地址
end
end

assign out_address = address;//输出这个地址

endmodule
