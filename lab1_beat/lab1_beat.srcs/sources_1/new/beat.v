`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/28 16:50:23
// Design Name: 
// Module Name: beat
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


module beat(
    input wire clk,
    input wire reset,
    output reg [3:0] beat
    );

    reg [3:0] shift_reg;  // 定义4位寄存器变量shift_reg  
	      
	always @(posedge clk or posedge reset) begin  
	        if (reset)  // 如果复位信号为高电平  
	            shift_reg <= 4'b1000;  // 将shift_reg设置为4位二进制数1000  
	        else  
            shift_reg <= {shift_reg[0], shift_reg[3:1]};  // 将shift_reg向右移动一位，最低位为原来的最高位  
	        beat <= shift_reg;  // 将shift_reg的值赋给输出信号pulse  
	end  

endmodule