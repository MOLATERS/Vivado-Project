`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/01 17:01:24
// Design Name: 
// Module Name: Regfile
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

module Regfile(
    input clk,//时钟信号
    input [4:0] raddr1,//寄存器堆读地址1
    output [31:0] rdata1,//返回数据1
    input [4:0] raddr2,//寄存器堆读地址2
    output [31:0] rdata2,//返回数据2
    input we,//写使能
    input [4:0]waddr,//写地址
    input [31:0]wdata//写数据
    );
    parameter ADDR = 5 ;//地址宽度
    parameter NUMB = 1<<ADDR;//寄存器个数
    parameter SIZE = 32;//寄存器数据位宽

    reg [SIZE-1:0] Reg_files [0:NUMB-1];//寄存器堆

    integer i = 0;
    initial begin//初始化寄存器
        repeat(32) begin
            Reg_files[i]<=0;
            i=i+1;
    end
    end

    always @(posedge clk) begin
        if(we) Reg_files[waddr] <= wdata;//如果使能变化且到达时钟的上升沿
    end

    assign rdata1 = Reg_files[raddr1];
    assign rdata2 = Reg_files[raddr2];
endmodule
