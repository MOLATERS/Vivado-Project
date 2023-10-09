`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/06 22:59:09
// Design Name: 
// Module Name: EX_MEM
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


module EX_MEM(
        input clk,
        input resetn,

        input [31:0] cpc,
        output reg [31:0] outpc,

        input [1:0] pcsourse,
        output reg [1:0] outpcsourse,
        input [31:0] npc,
        input [31:0] bpc,
        output reg [31:0] npcout,
        output reg [31:0] bpcout,
    //CU的控制部分
        input wreg,
        input [1:0] m2reg,
        input wmem,

        output reg outwreg,
        output reg [1:0] outm2reg,
        output reg outwmem,

    //ALU的输出部分
        input [31:0] aluout,
        output [31:0] out_aluout,

    //数值传递部分
        input [31:0] EX_rb,
        input [4:0] EX_rn,

        output [31:0] MEM_rb,
        output reg [4:0] MEM_rn,

    //指令存储
        input [31:0] EX_ir,
        output [31:0] MEM_ir
    );

    Container ALUout(
        .resetn(resetn),
        .in(aluout),
        .out(out_aluout),
        .clk(clk)
    );

    Container EX_MEM_IR(
        .resetn(resetn),
        .in(EX_ir),
        .out(MEM_ir),
        .clk(clk)
    );

    Container B(
        .resetn(resetn),
        .in(EX_rb),
        .out(MEM_rb),
        .clk(clk)
    );

    // always@(*) begin
    // end

    always @(posedge clk) begin
     if(!resetn) begin
        outwreg <= 32'h00000000;
        outm2reg <= 32'h00000000;
        outwmem <= 32'h00000000;
        MEM_rn <= 32'h00000000;
        outpc <= 32'h00000000;
        outpcsourse <= 32'h00000000;
        npcout <= 32'h00000000;
        bpcout <= 32'h00000000;
    end
    else if (EX_ir == 32'h00000000) begin
        outm2reg <= 0;
        outwmem <= 0;
        MEM_rn <= 5'b00000;
        outpcsourse <= 0;
        npcout <= 32'h00000000;
        outpc <= cpc;
        bpcout <= bpc;
        end
    else begin
        outpcsourse <= pcsourse;
        npcout <= npc;
        bpcout <= bpc;
        outwreg <= wreg;
        outm2reg <= m2reg;
        outwmem <= wmem;
        MEM_rn <= EX_rn;
        outpc <= cpc;
    end
    end

endmodule
