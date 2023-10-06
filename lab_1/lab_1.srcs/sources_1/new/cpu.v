`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/06 20:11:19
// Design Name: 
// Module Name: cpu
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


module cpu(
    input           clk,           // clock, 100MHz
    input           resetn,        // active low

    // debug signals
    output [31:0]   debug_wb_pc,    // 当前正在执行指令的 PC
    output          debug_wb_rf_wen, // 当前通用寄存器组的写使能信号
    output [4:0]    debug_wb_rf_addr,// 当前通用寄存器组写回的寄存器编号
    output [31:0]   debug_wb_rf_wdata // 当前指令需要写回的数据
    );



endmodule
