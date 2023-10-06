`timescale 1ns / 1ps
`define ADD     5'b00001
// 加
`define ADDI    5'b00010
// 加进位
`define SUB     5'b00011
// 减
`define SUBI    5'b00100
//减进位
`define RSUB    5'b00101
//反减
`define RSUBI   5'b00110
//反减再减进位
`define GA      5'b00111
//赋值为A
`define GB      5'b01000
//赋值为B
`define NEGA    5'b01001
//A取反
`define NEGB    5'b01010
//B取反
`define OR      5'b01011
//或
`define AND     5'b01100
//与
`define XNOR    5'b01101
//同或
`define XOR     5'b01110
//异或
`define NAND    5'b01111
//与取反
`define ZERO    5'b10000
//置零
`define SLT     5'b10001
//小于
`define SLL     5'b10010
//左移
`define PC      5'b10011
//更新PC
module CU(
    input [31:0] Instruct,      // 输入指令
    input Zero,                 // 零标志位
    output reg ram_w,           // 存储器写使能
    output reg reg_w,           // 寄存器写使能
    output reg [4:0] alu_card,      // ALU功能码
    output reg [1:0] PC_s,            // PC数据来源选择
    output reg [1:0] regfile_s,       // 寄存器文件数据来源选择
    output reg [1:0] regfile_addr_s,  // 寄存器文件地址来源选择
    output reg [1:0] ALU_As,          // ALU输入A来源选择
    output reg [1:0] ALU_Bs           // ALU输入B来源选择
    );

    reg [5:0] Op;
    reg [5:0] Func;
    
    always @(*) begin
        Func <= Instruct[31:26];
        Op <= Instruct[5:0];
        case (Func)
            6'b000000: begin
                case (Op)
                    6'b100000: begin // 加法操作
                        ram_w <= 0;            // 存储器写禁用
                        reg_w <= 1;            // 寄存器写使能
                        alu_card <= `ADD;             // ALU功能码为加法
                        PC_s <= 0;             // PC数据来源：NPC
                        regfile_s <= 0;        // 寄存器文件数据来源：ALU
                        regfile_addr_s <= 0;   // 寄存器文件地址来源：目标寄存器（rd）
                        ALU_As <= 0;           // ALU输入A来源：寄存器A
                        ALU_Bs <= 0;           // ALU输入B来源：寄存器B
                    end
                    6'b100010: begin // 减法操作
                        ram_w <= 0;
                        reg_w <= 1;
                        alu_card <= `SUB;             // ALU功能码为减法
                        PC_s <= 0;
                        regfile_s <= 0;
                        regfile_addr_s <= 0;
                        ALU_As <= 0;
                        ALU_Bs <= 0;
                    end 
                    6'b100100: begin // 与操作
                        ram_w <= 0;
                        reg_w <= 1;
                        alu_card <= `AND;
                        PC_s <= 0;
                        regfile_s <= 0;
                        regfile_addr_s <= 0;
                        ALU_As <= 0;
                        ALU_Bs <= 0;
                    end
                    6'b100101: begin // 或操作
                        ram_w <= 0;
                        reg_w <= 1;
                        alu_card <= `OR;
                        PC_s <= 0;
                        regfile_s <= 0;
                        regfile_addr_s <= 0;
                        ALU_As <= 0;
                        ALU_Bs <= 0;
                    end
                    6'b100110: begin // 异或操作
                        ram_w <= 0;
                        reg_w <= 1;
                        alu_card <= `XOR;
                        PC_s <= 0;
                        regfile_s <= 0;
                        regfile_addr_s <= 0;
                        ALU_As <= 0;
                        ALU_Bs <= 0;
                    end
                    6'b101010: begin // SLT操作（设置小于）
                        ram_w <= 0;
                        reg_w <= 1;
                        alu_card <= `SLT;
                        PC_s <= 0;
                        regfile_s <= 0;
                        regfile_addr_s <= 0;
                        ALU_As <= 0;
                        ALU_Bs <= 0;
                    end
                    6'b001010: begin // MOVZ操作（如果为零则移动）
                        ram_w <= 0;
                        reg_w <= Zero;        // 如果零标志位为1，则寄存器写使能
                        alu_card <= `GB;
                        PC_s <= 0;
                        regfile_s <= 2;       // 寄存器文件数据来源：寄存器A
                        regfile_addr_s <= 0;
                        ALU_As <= 0;
                        ALU_Bs <= 0;
                    end
                    6'b000000: begin // SLL操作（逻辑左移）
                        ram_w <= 0;
                        reg_w <= 1;
                        alu_card <= `SLL;
                        PC_s <= 0;
                        regfile_s <= 0;
                        regfile_addr_s <= 0;
                        ALU_As <= 3;          // ALU输入A来源：指令中的位移量（sa）
                        ALU_Bs <= 0;          // ALU输入B来源：寄存器B
                    end
                    default: begin
                        ram_w <= 0;            // 默认值
                        reg_w <= 0;
                        alu_card <= 0;
                        PC_s <= 0;
                        regfile_s <= 0;
                        regfile_addr_s <= 0;
                        ALU_As <= 0;
                        ALU_Bs <= 0;
                    end
                endcase
            end 
            6'b101011: begin // SW操作（存储字）
                ram_w <= 1;            // 存储器写使能
                reg_w <= 0;
                alu_card <= `ADD;      // ALU功能码用于地址计算
                PC_s <= 0;
                regfile_s <= 0;
                regfile_addr_s <= 1;    // 地址来源：寄存器rt
                ALU_As <= 2;            // ALU输入A来源：指令中的base部分
                ALU_Bs <= 1;            // ALU输入B来源：寄存器Imm
            end
            6'b100011: begin // LW操作（加载字）
                ram_w <= 0;
                reg_w <= 1;
                alu_card <= `ADD;      // ALU功能码用于地址计算
                PC_s <= 0;
                regfile_s <= 1;         // 寄存器文件数据来源：寄存器LMD
                regfile_addr_s <= 1;    // 地址来源：寄存器rt
                ALU_As <= 2;            // ALU输入A来源：指令中的base部分
                ALU_Bs <= 1;            // ALU输入B来源：寄存器Imm
            end
            6'b000101: begin // BNE操作（如果不相等则分支）
                ram_w <= 0;
                reg_w <= 0;
                alu_card <= `PC;       // ALU功能码用于分支地址计算
                if(Instruct[25:21]!=Instruct[20:16]) PC_s <= 1;  // PC数据来源：不相等跳转
                else PC_s <= 0;
                regfile_s <= 0;
                regfile_addr_s <= 0;
                ALU_As <= 1;            // ALU输入A来源：寄存器NPC
                ALU_Bs <= 1;            // ALU输入B来源：寄存器Imm
            end
            6'b000010: begin // J操作（跳转）
                ram_w <= 0;
                reg_w <= 0;
                alu_card <= 5'b00000;
                PC_s <= 2;              // PC数据来源：无条件跳转
                regfile_s <= 0;
                regfile_addr_s <= 0;
                ALU_As <= 2;
                ALU_Bs <= 2;
            end
            default: begin
                ram_w <= 0;            // 默认值
                reg_w <= 5'b00000;
                alu_card <= 0;
                PC_s <= 0;
                regfile_s <= 0;
                regfile_addr_s <= 0;
                ALU_As <= 0;
                ALU_Bs <= 0;
            end
        endcase
    end
endmodule
