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

        //接收CU的输入
        input wreg,
        input [4:0] aluc,
        input [1:0] pcsourse,
        input [1:0] m2reg,
        input [1:0] regaddr,
        input [2:0] asourse,
        input [2:0] bsourse,

        //CU数值传递
        output outwreg,
        output [4:0] outaluc,
        output [1:0] outpcsourse,
        output [1:0] outm2reg,
        output [1:0] outregaddr,
        output [2:0] outasourse,
        output [2:0] outbsourse,

        //交给ALU的参数        
        input [31:0] ID_ra,
        input [31:0] ID_rb,
        input [31:0] ID_Imm,
        output [31:0] EX_ra,
        output [31:0] EX_rb,
        output [31:0] EX_Imm,

        //决定写入的地址
        input [4:0] ID_rn,
        output [4:0] EX_rn
    );


endmodule
