`timescale 1ns / 1ps
`define INS_FILE_PATH "E:\\Xlinx_project\\lab_1\\lab_1.data\\base_inst_data"

module IMEM(
    input         clk      ,//时钟信号
    input  [7:0]  imem_addr ,//选定存储地址
    output reg [31:0] imem_rdata//读出的指令
);
    parameter ADDR = 8 ;//地址宽度
    parameter NUMB = 1<<ADDR;//寄存器个数
    parameter SIZE = 32;//寄存器数据位宽
    wire [7:0] addr;
    assign addr = (imem_addr % 4 == 0)? imem_addr>>2 : 8'b0;
    reg [SIZE-1:0] IMEM [0:NUMB-1];//存储器堆

    initial begin//初始化寄存器
    $readmemh(`INS_FILE_PATH , IMEM);
    end

    always @(posedge clk) begin //根据时钟信号决定写入（上升沿写入）
        imem_rdata <= IMEM[addr];
    end
endmodule
