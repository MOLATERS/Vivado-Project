`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/02 10:25:40
// Design Name: 
// Module Name: pc_adder_res
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


module pc_adder_res(
    input wire rst,    
    input wire [31:0] NPC_in,
    output reg [31:0] NPC_out
    );
    
  always @(*) begin
    if (!rst) begin
      
      NPC_out <= 32'h00000000;
    end else  begin
      NPC_out <= NPC_in;
    end
  end
endmodule