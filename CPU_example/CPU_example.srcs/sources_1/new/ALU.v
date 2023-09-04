`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/30 18:05:20
// Design Name: 
// Module Name: ALU
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


`define ADD 1
`define ADD_C 2
`define SUB 3
`define SUB_C 4
`define SUB_B 5
`define SUB_A 6
`define PUT_A 7
`define PUT_B 8
`define PUT_NA 9
`define PUT_NB 10
`define A_OR_B 11
`define A_AND_B 12
`define A_NXOR_B 13
`define A_XOR_B 14
`define N_A_AND_B 15
`define ZERO 16//运算操作编码
`define LM 17
`define PC 18
`define SMALL 19
module ALU(

input [31:0] A ,
input [31:0] B ,
input Cin ,
input [4:0] Card,

output [31:0] F ,
output Cout,
output Zero

    );
    
wire [32:0] answer_1;
wire [32:0] answer_2;
wire [32:0] answer_3;
wire [32:0] answer_4;
wire [32:0] answer_5;
wire [32:0] answer_6;
wire [31:0] answer_7;
wire [31:0] answer_8;
wire [31:0] answer_9;
wire [31:0] answer_10;
wire [31:0] answer_11;
wire [31:0] answer_12;
wire [31:0] answer_13;
wire [31:0] answer_14;
wire [31:0] answer_15;
wire [31:0] answer_16;
wire [31:0] answer_17;
wire [31:0] answer_18;
wire [31:0] answer_19;

assign answer_1 =  A + B;
assign answer_2 =  A + B + Cin;
assign answer_3 =  A - B;
assign answer_4 =  A - B - Cin;
assign answer_5 =  B - A;
assign answer_6 =  B - A - Cin;
assign answer_7 =  A;
assign answer_8 = B;
assign answer_9 = ~A;
assign answer_10 = ~B;
assign answer_11 = A|B;
assign answer_12 = A&B;
assign answer_13 = ~(A^B);
assign answer_14 = A^B;
assign answer_15 = ~(A&B);
assign answer_16 = 0;//进行相应的运算
assign answer_17 = B << A;
assign answer_18 = { B[29:0], 2'b00 } + A;
assign answer_19 = answer_3[32];
assign F      =      (Card == `ADD)?  answer_1[31:0]:
                     (Card == `ADD_C)? answer_2[31:0]:
                     (Card == `SUB)? answer_3[31:0]:
                     (Card == `SUB_C)? answer_4[31:0]:
                     (Card == `SUB_B)? answer_5[31:0]:
                     (Card == `SUB_A)? answer_6[31:0]:
                     (Card == `PUT_A)? answer_7:
                     (Card == `PUT_B)? answer_8:
                     (Card == `PUT_NA)? answer_9:
                     (Card == `PUT_NB)? answer_10:
                     (Card == `A_OR_B)? answer_11:
                     (Card == `A_AND_B)? answer_12:
                     (Card == `A_NXOR_B)? answer_13:
                     (Card == `A_XOR_B)? answer_14:
                     (Card == `N_A_AND_B)? answer_15:
                     (Card == `ZERO)? answer_16 : 
                     (Card == 17)  ?  answer_17[31:0]:
                     (Card == 18)  ?  answer_18:
                     (Card == 19)  ?  answer_19 : 99;
                     
   assign Zero = (F == 1'b0)? 1'b1:1'b0;//如果结果是0，那么就将0标志设置为1
   
   assign Cout = (Card == `ADD)?  answer_1[32]:
                     (Card == `ADD_C)? answer_2[32]:
                     (Card == `SUB)? answer_3[32]:
                     (Card == `SUB_C)? answer_4[32]:
                     (Card == `SUB_B)? answer_5[32]:
                     (Card == `SUB_A)? answer_6[32]:0;//输出不同情况下的进位标志
                  
endmodule
