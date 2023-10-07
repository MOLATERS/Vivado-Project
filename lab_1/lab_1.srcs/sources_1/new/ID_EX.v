`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/06 22:59:09
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
        input clk,

        //接收CU的输入
        input wmem,
        input wreg,
        input [4:0] aluc,
        input [1:0] m2reg,
        input [2:0] asourse,
        input [2:0] bsourse,

        //CU数值传递
        output reg outwmem,
        output reg outwreg,
        output reg [4:0] outaluc,
        output reg [1:0] outm2reg,
        output reg [2:0] outasourse,
        output reg [2:0] outbsourse,

        //交给ALU的参数        
        input [31:0] ID_ra,
        input [31:0] ID_rb,
        input [31:0] ID_Imm,
        output reg [31:0] EX_ra,
        output reg [31:0] EX_rb,
        output reg [31:0] EX_Imm,

        //决定写入的地址
        input [4:0] ID_rn,
        output reg [4:0] EX_rn,

        //接收IR
        input [31:0] ID_inst,
        output reg [31:0] EX_inst
    );

    always @(posedge clk) begin
        EX_inst <= ID_inst;
        EX_Imm <= ID_Imm;
        EX_ra <= ID_ra;
        EX_rb <= ID_rb;
        EX_rn <= ID_rn;
        outwmem <= wmem;
        outwreg <= wreg;
        outaluc <= outaluc;
        outasourse <= asourse;
        outbsourse <= bsourse;
    end



endmodule
