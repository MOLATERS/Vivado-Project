`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/31 22:49:47
// Design Name: 
// Module Name: PC_Cond
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


module PC_Cond(
input [31:0] in_A,
input [31:0] in_B,//������������
input [1:0] mode,//�ɿ�������������ѡ��
output reg [1:0] choose//���ѡ������ź�
    );
    
always @(*) begin
   if ( mode == 0 )begin
       choose = 0;//ѡ��NPC
   end 
   
   else if ( mode == 1 ) begin
           if ( in_A != in_B ) begin
              choose = 1;//���������ת
           end
           
           else begin
              choose = 0;//�������ʹ��NPC
           end
   end
   
   else begin
         choose = 2;//��������ת
   end
   
end    
endmodule
