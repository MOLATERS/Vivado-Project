`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/30 18:20:01
// Design Name: 
// Module Name: CU
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


module CU(

input [5:0] Func,//操作码
input [5:0] Op,//运算方式编码
input Zero,//零标志

output  reg ram_w,//存储器（数据存储器）写使能标志
output  reg reg_w,//寄存器写使能标志
output  reg [4:0] ALU_Op,//运算器操作码
output  reg [1:0] PC_s,//PC的数据来源
output  reg [1:0] regfile_s,//寄存器的数据来源
output  reg [1:0] regfile_addr_s,//寄存器的地址来源
output  reg [1:0] ALU_A_s,//运算器输入A的数据来源
output  reg [1:0] ALU_B_s//运算器输入B的数据来源
    );

always @ (*) begin //开始指令译码（指令码点）
     case (Func)
     6'b000000: begin//运算指令
               case(Op)
               6'b100000:begin
               ram_w     <= 0;//存储器不可写
               reg_w     <= 1;//寄存器可写
               ALU_Op    <= 1;//加法
               PC_s      <= 0;//PC的值为NPC
               regfile_s <= 0;//寄存器数据来源为ALU
               regfile_addr_s <= 0;//地址来源于目的寄存器rd
               ALU_A_s   <= 0;//ALU输入A来源于寄存器A
               ALU_B_s   <= 0;//ALU输入B来源于寄存器B
               end//加法
               
               6'b100010: begin
               ram_w     <= 0;//存储器不可写
               reg_w     <= 1;//寄存器可写
               ALU_Op    <= 3;//减法
               PC_s      <= 0;//PC的值为NPC
               regfile_s <= 0;//寄存器数据来源为ALU
               regfile_addr_s <= 0;//地址来源于目的寄存器rd
               ALU_A_s   <= 0;//ALU输入A来源于寄存器A
               ALU_B_s   <= 0;//ALU输入B来源于寄存器B
               end//减法
               
               6'b100100: begin
               ram_w     <= 0;//存储器不可写
               reg_w     <= 1;//寄存器可写
               ALU_Op    <= 12;//与运算
               PC_s      <= 0;//PC的值为NPC
               regfile_s <= 0;//寄存器数据来源为ALU
               regfile_addr_s <= 0;//地址来源于目的寄存器rd
               ALU_A_s   <= 0;//ALU输入A来源于寄存器A
               ALU_B_s   <= 0;//ALU输入B来源于寄存器B
               end//与运算
               
               6'b100101: begin
               ram_w     <= 0;//存储器不可写
               reg_w     <= 1;//寄存器可写
               ALU_Op    <= 11;//或运算
               PC_s      <= 0;//PC的值为NPC
               regfile_s <= 0;//寄存器数据来源为ALU
               regfile_addr_s <= 0;//地址来源于目的寄存器rd
               ALU_A_s   <= 0;//ALU输入A来源于寄存器A
               ALU_B_s   <= 0;//ALU输入B来源于寄存器B
               end//或运算
               
               6'b100110: begin
               ram_w     <= 0;//存储器不可写
               reg_w     <= 1;//寄存器可写
               ALU_Op    <= 14;//异或运算
               PC_s      <= 0;//PC的值为NPC
               regfile_s <= 0;//寄存器数据来源为ALU
               regfile_addr_s <= 0;//地址来源于目的寄存器rd
               ALU_A_s   <= 0;//ALU输入A来源于寄存器A
               ALU_B_s   <= 0;//ALU输入B来源于寄存器B
               end//异或运算
               
               6'b101010:begin
               ram_w     <= 0;//存储器不可写
               reg_w     <= 1;//寄存器可写
               ALU_Op    <= 19;//小于运算
               PC_s      <= 0;//PC的值为NPC
               regfile_s <= 0;//寄存器数据来源为ALU
               regfile_addr_s <= 0;//地址来源于目的寄存器rd
               ALU_A_s   <= 0;//ALU输入A来源于寄存器A
               ALU_B_s   <= 0;//ALU输入B来源于寄存器B
               end //小于
               
               6'b001010:begin
               ram_w     <= 0;//存储器不可写
               reg_w     <= Zero;//如果结果为0那么就可以写入寄存器
               ALU_Op    <= 8;//把输入B输出，也就是寄存器rt输出
               PC_s      <= 0;//PC的值为NPC
               regfile_s <= 2;//寄存器来源为寄存器A
               regfile_addr_s <= 0;//地址来源于目的寄存器rd
               ALU_A_s   <= 0;//ALU输入A来源于寄存器A
               ALU_B_s   <= 0;//ALU输入B来源于寄存器B
               end//条件移动
               

               6'b000000:begin
               ram_w     <= 0;//存储器不可写
               reg_w     <= 1;//寄存器可写
               ALU_Op    <= 17;//左移
               PC_s      <= 0;//PC的值为NPC
               regfile_s <= 0;//寄存器来源为ALU
               regfile_addr_s <= 0;//地址来源于目的寄存器rd
               ALU_A_s   <= 3;//ALU输入A来源于指令sa段
               ALU_B_s   <= 0;//ALU输入B来源于寄存器B
               end//移位
               
               endcase 
     end
     6'b101011:begin
               ram_w     <= 1;//存储器可写
               reg_w     <= 0;//寄存器不可写
               ALU_Op    <= 1;//加法求得地址
               PC_s      <= 0;//PC的值为NPC
               regfile_s <= 0;//无关
               regfile_addr_s <= 1;//地址来源于寄存器rt
               ALU_A_s   <= 2;//ALU输入A来源于指令中base部分
               ALU_B_s   <= 1;//ALU输入B来源于寄存器Imm
               end//存数
               
     6'b100011:begin
               ram_w     <= 0;//存储器不可写
               reg_w     <= 1;//寄存器可写
               ALU_Op    <= 1;//加法求得地址
               PC_s      <= 0;//PC的值为NPC
               regfile_s <= 1;//寄存器数据来源于寄存器LMD
               regfile_addr_s <= 1;//地址来源于寄存器rt
               ALU_A_s   <= 2;//ALU输入A来源于指令中base部分
               ALU_B_s   <= 1;//ALU输入B来源于寄存器Imm
               end//取数
     
     6'b000101:begin
               ram_w     <= 0;//存储器不可写
               reg_w     <= 0;//寄存器不可写
               ALU_Op    <= 18;//ALU直接求得转移地址
               PC_s      <= 1;//不相等跳转
               regfile_s <= 0;//无关
               regfile_addr_s <= 0;//无关
               ALU_A_s   <= 1;//寄存器A来自于NPC
               ALU_B_s   <= 1;//寄存器B来自于Imm
               end//条件转移
               
     6'b000010:begin
               ram_w     <= 0;//存储器不可写
               reg_w     <= 0;//寄存器不可写
               ALU_Op    <= 0;//无关
               PC_s      <= 2;//无条件跳转
               regfile_s <= 0;//无关
               regfile_addr_s <= 0;//无关
               ALU_A_s   <= 2;//无关
               ALU_B_s   <= 2;//无关
               end//无条件转移
               
     default :begin
               ram_w     <= 0;//默认为0
               reg_w     <= 0;//默认为0
               ALU_Op    <= 0;//默认为0
               PC_s      <= 0;//默认为0
               regfile_s <= 0;//默认为0
               regfile_addr_s <= 0;//默认为0
               ALU_A_s   <= 0;//默认为0
               ALU_B_s   <= 0;//默认为0
               end//出错
               
     endcase 
end

endmodule
