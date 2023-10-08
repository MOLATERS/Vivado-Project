`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/06 22:59:09
// Design Name: 
// Module Name: MEM_WB
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


module MEM_WB(
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

        //CU控制输入
        input wreg,
        input [1:0] m2reg,
        output reg outwreg,
        output reg [1:0] outm2reg,

        //ALU结果传递
        input [31:0] aluout,
        output [31:0] out_aluout,

        //MEM结果传递
        input [31:0] ldm,
        output [31:0] outldm,

        //rn传递
        input [4:0] MEM_rn,
        output reg [4:0] WB_rn,

        //INSTRUCTION传递
        input [31:0] MEM_inst,
        output [31:0] WB_inst
    );

    Container ALUout(
        .in(aluout),
        .out(out_aluout),
        .clk(clk),
        .resetn(resetn)
    );

    Container MEM_WB_IR(
        .in(MEM_inst),
        .out(WB_inst),
        .clk(clk),
        .resetn(resetn)
    );

    Container LMD(
        .in(ldm),
        .out(outldm),
        .clk(clk),
        .resetn(resetn)
    );

    // always@(*) begin
    // end

    always @(posedge clk or negedge resetn) begin
        if(!resetn)begin
        outpcsourse <= 32'h00000000;
        npcout <= 32'h00000000;
        bpcout <= 32'h00000000;
        outm2reg <= 0;
        outwreg <= 0;
        WB_rn <= 5'b00000;
        outpc <= 32'h00000000;
        end
        else if (MEM_inst == 32'h00000000) begin
        outpcsourse <= 32'h00000000;
        npcout <= 32'h00000000;
        bpcout <= 32'h00000000;
        outm2reg <= 0;
        outwreg <= 0;
        WB_rn <= 5'b00000;
        outpc <= 32'h00000000;
        end
        else begin
        outpcsourse <= pcsourse;
        npcout <= npc;
        bpcout <= bpc;
        outm2reg <= m2reg;
        outwreg <= wreg;
        WB_rn <= MEM_rn;
        outpc <= cpc;
        end
    end

endmodule
