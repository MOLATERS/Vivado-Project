`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/30 18:41:52
// Design Name: 
// Module Name: IR
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


module IR(//ָ��Ĵ���
input reset,
input [31:0] in_ins,

output [31:0] out_ins
    );
    
reg [31:0] instruction;//ָ��Ĵ���

always @ (*) begin
     if (!reset) begin//�����ʼ����ôȫ����Ϊ0
         instruction <= 32'h0;
     end
     
     else begin
         instruction <= in_ins;
     end
end

assign out_ins = instruction;

endmodule
