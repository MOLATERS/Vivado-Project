`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/30 18:04:10
// Design Name: 
// Module Name: PC
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


module PC(//���������

input clk,
input reset,
input  [31:0] in_address,

output [31:0] out_address

    );
    
reg [31:0] address;
initial begin
     address <= 32'b0;
end

always @ ( posedge clk ) begin
if (!reset) begin
           address <= 32'b0;//�����ʼ����ô������Ϊȫ0
end

else begin
           address <= in_address;//���û�г�ʼ������ô�͸��³�Ϊ����ĵ�ַ
end
end

assign out_address = address;//��������ַ

endmodule
