`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/02 10:51:19
// Design Name: 
// Module Name: ID_EX
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


module ID_EX(
    input wire clk,
    input wire [31:0]NPC_in,
    input wire reset,   
    input wire [31:0]rdata1,
    input wire [31:0]rdata2,
    input wire [31:0]immer_in,
    input wire [31:0]ir_in,
    input wire [31:0] PC,
    output reg [31:0] CPC,
    output reg [31:0]NPC,
    output reg [31:0]A,
    output reg [31:0]B,
    output reg [31:0]IMM,
    output reg [31:0]IR,
    output [4:0]Card   
    );
    always @(posedge clk or negedge reset) begin
    if(!reset) 
        begin
            NPC=0;
            A=0;
            B=0;
            IMM=0;
            IR=0;
            CPC=0;
        end
    else if (ir_in==8'h00000000)
    begin
        NPC=0;
            A=0;
            B=0;
            IMM=0;
            IR=0;
            CPC=PC;
    end
    else
        begin
            NPC=NPC_in;
            A=rdata1;
            B=rdata2;
            IMM=immer_in;
            IR=ir_in; 
            CPC=PC;
        end

end
CU cu(
   .clk(clk),
   .ir(ir_in),
   .card(Card),
   .rdata1(rdata1),
   .rdata2(rdata2)
   );
endmodule
