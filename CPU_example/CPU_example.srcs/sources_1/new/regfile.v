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


module regfile(//�Ĵ�����
input clk,
input [4:0] raddr1,
input [4:0] raddr2,
input we,
input [4:0]waddr,
input [31:0]wdata,//д���ݵ�ʱ����ͬ��

output [31:0] rdata1,
output [31:0] rdata2//�����ݵ�ʱ�����첽
    );

reg [31:0] regsiter [0:31];//�洢�ļĴ����������Ĵ�����

integer i;
initial begin //��ʼ���Ĵ�����
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