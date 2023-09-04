`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/30 18:05:51
// Design Name: 
// Module Name: regfile
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


module regfile(//寄存器堆
input clk,
input [4:0] raddr1,
input [4:0] raddr2,
input we,
input [4:0]waddr,
input [31:0]wdata,//写数据的时候是同步

output [31:0] rdata1,
output [31:0] rdata2//读数据的时候是异步
    );

reg [31:0] regsiter [0:31];//存储的寄存器，构建寄存器堆

integer i;
initial begin //初始化寄存器堆
   for (i = 0;i <= 31;i = i + 1) begin
       regsiter [i] <= 32'b0;
   end
end

always @(posedge clk) begin

    if( we ) begin
        regsiter[ waddr ] <= wdata;
    end
    
end

assign rdata1 = regsiter[ raddr1 ];
assign rdata2 = regsiter[ raddr2 ];

endmodule