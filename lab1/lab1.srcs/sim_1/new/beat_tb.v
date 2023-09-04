`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/28 16:45:11
// Design Name: 
// Module Name: beat_tb
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


module beat_tb();
        reg clk;           // 定义时钟信号变量  
	    reg reset;         // 定义复位信号变量  
	    wire [3:0] pulse;  // 定义脉冲信号变量，4位寄存器  
	    beat dut (   // 实例化pulse_generator模块，并连接信号  
	        .clk(clk),          // 连接时钟信号  
	        .reset(reset),      // 连接复位信号  
	        .beat(pulse)       // 连接脉冲信号  
	    );  
	    initial begin  
	        clk = 0;        // 初始化时钟信号为低电平  
	        reset = 1;      // 初始化复位信号为高电平  
	        #10;            // 等待10个时间单位  
	        dut.shift_reg <= 4'b1000;  // 将dut模块中的shift_reg设置为4位二进制数1000  
	        repeat (4) begin  
	            #5;         
	            clk = ~clk; // 切换时钟信号的状态  
	        end  
	          
	        #5;           
	        reset = 0;      // 将复位信号置为低电平  
	        #10;             
	          
	        repeat (8) begin  
	            #5;           
	            clk = ~clk; // 切换时钟信号的状态  
	        end  
	          
	        #10;           
	        $finish;        
	    end  
	endmodule  
