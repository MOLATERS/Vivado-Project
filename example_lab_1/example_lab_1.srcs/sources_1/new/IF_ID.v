`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/02 10:30:36
// Design Name: 
// Module Name: IF_ID
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


module IF_ID(
input wire clk,
input wire NPC_in,
input wire [31:0]IR,
input wire reset,
input wire stop,
input wire [31:0] PC,
output reg [31:0] CPC,
output reg [31:0]NPC,
output reg [31:0]ir
    );

always @(posedge clk or negedge reset) begin
if (!stop)
begin
    if(!reset) 
        begin
            ir=0;
            NPC=0;
            CPC=0;
        end
    else if (IR==8'h00000000)
    begin
        ir=0;
        NPC=0;
        CPC=PC;
    end
    else
        begin
            ir=IR;
            NPC=NPC_in;
            CPC=PC;
        end
         
end
end
endmodule
