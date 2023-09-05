`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/01 15:10:07
// Design Name: 
// Module Name: IMEM
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
`define INS_FILE_PATH "E:\\Xlinx_project\\lab_4\\lab4.data\\inst_data.txt"

module IMEM(
    input         clk      ,//时钟信号
    input  [7:0]  imem_addr ,//选定存储地址
    output [31:0] imem_rdata//读出的指令
);
    parameter ADDR = 8 ;//地址宽度
    parameter NUMB = 1<<ADDR;//寄存器个数
    parameter SIZE = 32;//寄存器数据位宽
    wire [7:0] addr;
    assign addr = (imem_addr % 4 == 0)? imem_addr>>2 : 8'b0;
    reg [SIZE-1:0] IMEM [0:NUMB-1];//存储器堆
    
    integer i = 0;
    initial begin//初始化寄存器
    $readmemh(`INS_FILE_PATH , IMEM);
    end

    assign imem_rdata = IMEM[addr];

endmodule
