`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/31 19:46:14
// Design Name: 
// Module Name: signal
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

module signal(//信号生成器，生成五段信号
input clk,
input rst,
output [4:0]T
    );
     reg [4:0]sig;
   
   always @(posedge  clk)begin 
   
   if (!rst) begin
   sig <= 5'b00001;
   end
   
   else begin
   repeat (5) begin
   sig <= {sig[0],sig[4:1]};
   #1;
   end
   end
   
   end 
   
   assign T = sig;
   
endmodule
